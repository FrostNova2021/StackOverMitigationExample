
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/EHPersonalities.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Mangler.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/InitializePasses.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/SpecialCaseList.h"
#include "llvm/Support/VirtualFileSystem.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include "llvm/Transforms/Instrumentation/StackOverflowMitigation.h"


using namespace llvm;


const char* String_StackOverflowMitigation_Ctor = "__StackOverflowMitigation_Ctor";
const char* String_StackOverflowMitigation_Init = "__StackOverflowMitigation_Init";

namespace {

class StackOverflowMitigationPass : public ModulePass {
public:
  StackOverflowMitigationPass(bool is_use = true)
   : ModulePass(ID) {
    initializeStackOverflowMitigationPassPass(
        *PassRegistry::getPassRegistry());
  }
  bool instrumentModule(Module &M);
  bool instrumentFunction(Function &F);
  bool runOnModule(Module &M) override {
    C = &(M.getContext());
    LongSize = M.getDataLayout().getPointerSizeInBits();
    IntTy = Type::getIntNTy(*C, LongSize);

    StackOverflowMitigationInit = createSanitizerCtor(M,String_StackOverflowMitigation_Init);

    std::tie(StackOverflowMitigationCtor,std::ignore) = 
        createSanitizerCtorAndInitFunctions(M,String_StackOverflowMitigation_Ctor,
            String_StackOverflowMitigation_Init,{},{});

    IRBuilder<> IRB_Ctor(StackOverflowMitigationInit->getEntryBlock().getTerminator());

    ExitFunction = M.getOrInsertFunction("exit",FunctionType::get(IRB_Ctor.getVoidTy(),{IntTy},false));
    TimeFunction = M.getOrInsertFunction("time",FunctionType::get(IRB_Ctor.getInt32Ty(),{IntTy},false));
    RandFunction = M.getOrInsertFunction("rand",FunctionType::get(IRB_Ctor.getInt32Ty(),{},false));
    SRandFunction = M.getOrInsertFunction("srand",FunctionType::get(IRB_Ctor.getInt32Ty(),{IntTy},false));

    GlobalStackSeed = new GlobalVariable(M, 
        IntTy,
        false,
        GlobalValue::ExternalLinkage ,
        0,
        "stack_cookie_seed");

    ConstantInt* const_int_val = ConstantInt::get(*C, APInt(32,0xF030));

    GlobalStackSeed->setAlignment(Align(LongSize / 8));
    GlobalStackSeed->setInitializer(const_int_val);

    Value* TimeTick = IRB_Ctor.CreateAlloca(IntTy, nullptr, "timetick");

    IRB_Ctor.CreateStore(
        IRB_Ctor.CreateCall(TimeFunction,{ConstantInt::get(IntTy,0)}),
        GlobalStackSeed);

    llvm::appendToGlobalCtors(M,StackOverflowMitigationCtor,1);

    return instrumentModule(M);
  }

  static char ID; // Pass identification, replacement for typeid
private:
  LLVMContext* C;

  int LongSize;
  Type* IntTy;

  GlobalVariable* GlobalStackSeed;

  Function* StackOverflowMitigationCtor;
  Function* StackOverflowMitigationInit;

  FunctionCallee SRandFunction;
  FunctionCallee TimeFunction;
  FunctionCallee RandFunction;
  FunctionCallee ExitFunction;
};


bool StackOverflowMitigationPass::instrumentModule(Module &M) {
    for (auto&F : M)
        instrumentFunction(F);

    return true;
}

/*

    magic_code = global_value

    -- code --

    if magic_code != global_value
        Crash !

*/

bool StackOverflowMitigationPass::instrumentFunction(Function &F) {
    auto& EB = F.getEntryBlock();
    auto& FI = *EB.begin();

    if (F.empty() || F.getLinkage() == GlobalValue::AvailableExternallyLinkage)
        return false;

    if (F.getName().startswith("__StackOverflow"))
        return false;

    IRBuilder<> IRB_AllocaStackCookie(&FI);
    Value* StackCookie = IRB_AllocaStackCookie.CreateAlloca(IntTy, nullptr, "stack_cookie");
    IRB_AllocaStackCookie.CreateStore(
        IRB_AllocaStackCookie.CreateLoad(IntTy,GlobalStackSeed),
        StackCookie);
    SmallVector<ReturnInst*,16> AllReturnInst;

    for (auto& BB : F)
        for (auto& Inst : BB)
            if (ReturnInst* RI = dyn_cast<ReturnInst>(&Inst))
                AllReturnInst.push_back(RI);

    for (auto ReturnInstruction : AllReturnInst) {
        IRBuilder<> IRB_Return(ReturnInstruction);
        Value* Cmp = IRB_Return.CreateICmpNE(
            IRB_Return.CreateLoad(IntTy,StackCookie),
            IRB_Return.CreateLoad(IntTy,GlobalStackSeed));
        Instruction *ThenTerm =
            SplitBlockAndInsertIfThen(Cmp,ReturnInstruction,false);

        IRBuilder<> IRB_CheckExcept(ThenTerm);
        IRB_CheckExcept.CreateCall(ExitFunction,{ConstantInt::get(IntTy,1)});
    }

    return true;
}

}

char StackOverflowMitigationPass::ID = 0;
INITIALIZE_PASS_BEGIN(StackOverflowMitigationPass, "StackOverflowMitigation",
                      "Stack Overflow Mitigation for Functions", false,
                      false)
INITIALIZE_PASS_END(StackOverflowMitigationPass, "StackOverflowMitigation",
                    "Stack Overflow Mitigation for Functions", false,
                    false)

namespace llvm {


PreservedAnalyses ModuleStackOverflowMitigationPass::run(Module &M,
                                                   ModuleAnalysisManager &MAM) {
  StackOverflowMitigationPass ModuleStackOverflow(true);

  if (ModuleStackOverflow.instrumentModule(M))
    return PreservedAnalyses::none();

  return PreservedAnalyses::all();
}


ModulePass* createStackOverflowMitigationPass(bool is_use) {
  return new StackOverflowMitigationPass(is_use);
}

}

