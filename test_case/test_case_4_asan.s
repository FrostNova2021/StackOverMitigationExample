; ModuleID = './test_case_4.c'
source_filename = "./test_case_4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = internal constant { [8 x i8], [56 x i8] } { [8 x i8] c"crash!\0A\00", [56 x i8] zeroinitializer }, align 32
@___asan_gen_ = private constant [16 x i8] c"./test_case_4.c\00", align 1
@___asan_gen_.1 = private unnamed_addr constant [17 x i8] c"<string literal>\00", align 1
@___asan_gen_.2 = private unnamed_addr constant [16 x i8] c"./test_case_4.c\00", align 1
@___asan_gen_.3 = private unnamed_addr constant { [16 x i8]*, i32, i32 } { [16 x i8]* @___asan_gen_.2, i32 8, i32 12 }
@llvm.compiler.used = appending global [1 x i8*] [i8* getelementptr inbounds ({ [8 x i8], [56 x i8] }, { [8 x i8], [56 x i8] }* @.str, i32 0, i32 0, i32 0)], section "llvm.metadata"
@0 = internal global [1 x { i64, i64, i64, i64, i64, i64, i64, i64 }] [{ i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint ({ [8 x i8], [56 x i8] }* @.str to i64), i64 8, i64 64, i64 ptrtoint ([17 x i8]* @___asan_gen_.1 to i64), i64 ptrtoint ([16 x i8]* @___asan_gen_ to i64), i64 0, i64 ptrtoint ({ [16 x i8]*, i32, i32 }* @___asan_gen_.3 to i64), i64 -1 }]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 1, void ()* @asan.module_ctor, i8* null }]
@llvm.global_dtors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 1, void ()* @asan.module_dtor, i8* null }]

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %buffer = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %0 = bitcast i8** %buffer to i8*, !dbg !14
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %0) #4, !dbg !14
  call void @llvm.dbg.declare(metadata i8** %buffer, metadata !15, metadata !DIExpression()), !dbg !18
  %call = call i8* @malloc(i64 10), !dbg !19
  store i8* %call, i8** %buffer, align 8, !dbg !18
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ({ [8 x i8], [56 x i8] }, { [8 x i8], [56 x i8] }* @.str, i32 0, i32 0, i64 0)), !dbg !20
  %1 = load i8*, i8** %buffer, align 8, !dbg !21
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 10, !dbg !21
  %2 = ptrtoint i8* %arrayidx to i64, !dbg !22
  %3 = lshr i64 %2, 3, !dbg !22
  %4 = add i64 %3, 2147450880, !dbg !22
  %5 = inttoptr i64 %4 to i8*, !dbg !22
  %6 = load i8, i8* %5, align 1, !dbg !22
  %7 = icmp ne i8 %6, 0, !dbg !22
  br i1 %7, label %8, label %13, !dbg !22, !prof !23

8:                                                ; preds = %entry
  %9 = and i64 %2, 7, !dbg !22
  %10 = trunc i64 %9 to i8, !dbg !22
  %11 = icmp sge i8 %10, %6, !dbg !22
  br i1 %11, label %12, label %13, !dbg !22

12:                                               ; preds = %8
  call void @__asan_report_store1(i64 %2) #5, !dbg !22
  unreachable

13:                                               ; preds = %8, %entry
  store i8 -1, i8* %arrayidx, align 1, !dbg !22
  %14 = bitcast i8** %buffer to i8*, !dbg !24
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %14) #4, !dbg !24
  ret i32 0, !dbg !25
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

declare dso_local i8* @malloc(i64) #3

declare dso_local i32 @printf(i8*, ...) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

declare void @__asan_report_load_n(i64, i64)

declare void @__asan_loadN(i64, i64)

declare void @__asan_report_load1(i64)

declare void @__asan_load1(i64)

declare void @__asan_report_load2(i64)

declare void @__asan_load2(i64)

declare void @__asan_report_load4(i64)

declare void @__asan_load4(i64)

declare void @__asan_report_load8(i64)

declare void @__asan_load8(i64)

declare void @__asan_report_load16(i64)

declare void @__asan_load16(i64)

declare void @__asan_report_store_n(i64, i64)

declare void @__asan_storeN(i64, i64)

declare void @__asan_report_store1(i64)

declare void @__asan_store1(i64)

declare void @__asan_report_store2(i64)

declare void @__asan_store2(i64)

declare void @__asan_report_store4(i64)

declare void @__asan_store4(i64)

declare void @__asan_report_store8(i64)

declare void @__asan_store8(i64)

declare void @__asan_report_store16(i64)

declare void @__asan_store16(i64)

declare void @__asan_report_exp_load_n(i64, i64, i32)

declare void @__asan_exp_loadN(i64, i64, i32)

declare void @__asan_report_exp_load1(i64, i32)

declare void @__asan_exp_load1(i64, i32)

declare void @__asan_report_exp_load2(i64, i32)

declare void @__asan_exp_load2(i64, i32)

declare void @__asan_report_exp_load4(i64, i32)

declare void @__asan_exp_load4(i64, i32)

declare void @__asan_report_exp_load8(i64, i32)

declare void @__asan_exp_load8(i64, i32)

declare void @__asan_report_exp_load16(i64, i32)

declare void @__asan_exp_load16(i64, i32)

declare void @__asan_report_exp_store_n(i64, i64, i32)

declare void @__asan_exp_storeN(i64, i64, i32)

declare void @__asan_report_exp_store1(i64, i32)

declare void @__asan_exp_store1(i64, i32)

declare void @__asan_report_exp_store2(i64, i32)

declare void @__asan_exp_store2(i64, i32)

declare void @__asan_report_exp_store4(i64, i32)

declare void @__asan_exp_store4(i64, i32)

declare void @__asan_report_exp_store8(i64, i32)

declare void @__asan_exp_store8(i64, i32)

declare void @__asan_report_exp_store16(i64, i32)

declare void @__asan_exp_store16(i64, i32)

declare i8* @__asan_memmove(i8*, i8*, i64)

declare i8* @__asan_memcpy(i8*, i8*, i64)

declare i8* @__asan_memset(i8*, i32, i64)

declare void @__asan_handle_no_return()

declare void @__sanitizer_ptr_cmp(i64, i64)

declare void @__sanitizer_ptr_sub(i64, i64)

declare void @__asan_before_dynamic_init(i64)

declare void @__asan_after_dynamic_init()

declare void @__asan_register_globals(i64, i64)

declare void @__asan_unregister_globals(i64, i64)

declare void @__asan_register_image_globals(i64)

declare void @__asan_unregister_image_globals(i64)

declare void @__asan_register_elf_globals(i64, i64, i64)

declare void @__asan_unregister_elf_globals(i64, i64, i64)

declare void @__asan_init()

define internal void @asan.module_ctor() {
  call void @__asan_init()
  call void @__asan_version_mismatch_check_v8()
  call void @__asan_register_globals(i64 ptrtoint ([1 x { i64, i64, i64, i64, i64, i64, i64, i64 }]* @0 to i64), i64 1)
  ret void
}

declare void @__asan_version_mismatch_check_v8()

define internal void @asan.module_dtor() {
  call void @__asan_unregister_globals(i64 ptrtoint ([1 x { i64, i64, i64, i64, i64, i64, i64, i64 }]* @0 to i64), i64 1)
  ret void
}

attributes #0 = { noinline nounwind optnone sanitize_address uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.asan.globals = !{!3}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.0-2", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test_case_4.c", directory: "/home/ubuntu/Desktop/instrument_note")
!2 = !{}
!3 = !{[8 x i8]* getelementptr inbounds ({ [8 x i8], [56 x i8] }, { [8 x i8], [56 x i8] }* @.str, i32 0, i32 0), !4, !"<string literal>", i1 false, i1 false}
!4 = !{!"./test_case_4.c", i32 8, i32 12}
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"Ubuntu clang version 11.0.0-2"}
!9 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 5, type: !11, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "./test_case_4.c", directory: "/home/ubuntu/Desktop/instrument_note")
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocation(line: 6, column: 5, scope: !9)
!15 = !DILocalVariable(name: "buffer", scope: !9, file: !10, line: 6, type: !16)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DILocation(line: 6, column: 11, scope: !9)
!19 = !DILocation(line: 6, column: 20, scope: !9)
!20 = !DILocation(line: 8, column: 5, scope: !9)
!21 = !DILocation(line: 9, column: 5, scope: !9)
!22 = !DILocation(line: 9, column: 16, scope: !9)
!23 = !{!"branch_weights", i32 1, i32 100000}
!24 = !DILocation(line: 12, column: 1, scope: !9)
!25 = !DILocation(line: 11, column: 5, scope: !9)
