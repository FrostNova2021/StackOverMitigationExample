; ModuleID = './test_case_5.cc'
source_filename = "./test_case_5.cc"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_Z9test_casei(i32 %0) #0 !dbg !7 {
  %2 = alloca i32, align 4
  %3 = alloca [10 x i8], align 1
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !12, metadata !DIExpression()), !dbg !13
  %4 = load i32, i32* %2, align 4, !dbg !14
  %5 = icmp eq i32 1, %4, !dbg !16
  br i1 %5, label %6, label %24, !dbg !17

6:                                                ; preds = %1
  %7 = load i32, i32* %2, align 4, !dbg !18
  %8 = icmp eq i32 2, %7, !dbg !20
  br i1 %8, label %9, label %23, !dbg !21

9:                                                ; preds = %6
  %10 = load i32, i32* %2, align 4, !dbg !22
  %11 = icmp eq i32 3, %10, !dbg !24
  br i1 %11, label %12, label %22, !dbg !25

12:                                               ; preds = %9
  %13 = load i32, i32* %2, align 4, !dbg !26
  %14 = icmp eq i32 4, %13, !dbg !28
  br i1 %14, label %15, label %21, !dbg !29

15:                                               ; preds = %12
  %16 = load i32, i32* %2, align 4, !dbg !30
  %17 = icmp eq i32 5, %16, !dbg !32
  br i1 %17, label %18, label %20, !dbg !33

18:                                               ; preds = %15
  call void @llvm.dbg.declare(metadata [10 x i8]* %3, metadata !34, metadata !DIExpression()), !dbg !39
  %19 = bitcast [10 x i8]* %3 to i8*, !dbg !39
  call void @llvm.memset.p0i8.i64(i8* align 1 %19, i8 0, i64 10, i1 false), !dbg !39
  br label %20, !dbg !40

20:                                               ; preds = %18, %15
  br label %21, !dbg !30

21:                                               ; preds = %20, %12
  br label %22, !dbg !26

22:                                               ; preds = %21, %9
  br label %23, !dbg !22

23:                                               ; preds = %22, %6
  br label %24, !dbg !18

24:                                               ; preds = %23, %1
  ret void, !dbg !41
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: noinline norecurse nounwind optnone uwtable
define dso_local i32 @main(i32 %0) #3 !dbg !42 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %2, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !45, metadata !DIExpression()), !dbg !46
  %4 = load i32, i32* %3, align 4, !dbg !47
  call void @_Z9test_casei(i32 %4), !dbg !48
  ret i32 1, !dbg !49
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn writeonly }
attributes #3 = { noinline norecurse nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "Ubuntu clang version 11.0.0-2", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test_case_5.cc", directory: "/home/ubuntu/Desktop/instrument_note")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.0-2"}
!7 = distinct !DISubprogram(name: "test_case", linkageName: "_Z9test_casei", scope: !8, file: !8, line: 2, type: !9, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "./test_case_5.cc", directory: "/home/ubuntu/Desktop/instrument_note")
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "length", arg: 1, scope: !7, file: !8, line: 2, type: !11)
!13 = !DILocation(line: 2, column: 20, scope: !7)
!14 = !DILocation(line: 3, column: 14, scope: !15)
!15 = distinct !DILexicalBlock(scope: !7, file: !8, line: 3, column: 9)
!16 = !DILocation(line: 3, column: 11, scope: !15)
!17 = !DILocation(line: 3, column: 9, scope: !7)
!18 = !DILocation(line: 4, column: 18, scope: !19)
!19 = distinct !DILexicalBlock(scope: !15, file: !8, line: 4, column: 13)
!20 = !DILocation(line: 4, column: 15, scope: !19)
!21 = !DILocation(line: 4, column: 13, scope: !15)
!22 = !DILocation(line: 5, column: 22, scope: !23)
!23 = distinct !DILexicalBlock(scope: !19, file: !8, line: 5, column: 17)
!24 = !DILocation(line: 5, column: 19, scope: !23)
!25 = !DILocation(line: 5, column: 17, scope: !19)
!26 = !DILocation(line: 6, column: 26, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !8, line: 6, column: 21)
!28 = !DILocation(line: 6, column: 23, scope: !27)
!29 = !DILocation(line: 6, column: 21, scope: !23)
!30 = !DILocation(line: 7, column: 30, scope: !31)
!31 = distinct !DILexicalBlock(scope: !27, file: !8, line: 7, column: 25)
!32 = !DILocation(line: 7, column: 27, scope: !31)
!33 = !DILocation(line: 7, column: 25, scope: !27)
!34 = !DILocalVariable(name: "buffer", scope: !31, file: !8, line: 8, type: !35)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !36, size: 80, elements: !37)
!36 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!37 = !{!38}
!38 = !DISubrange(count: 10)
!39 = !DILocation(line: 8, column: 30, scope: !31)
!40 = !DILocation(line: 8, column: 25, scope: !31)
!41 = !DILocation(line: 9, column: 1, scope: !7)
!42 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 11, type: !43, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!11, !11}
!45 = !DILocalVariable(name: "argv", arg: 1, scope: !42, file: !8, line: 11, type: !11)
!46 = !DILocation(line: 11, column: 14, scope: !42)
!47 = !DILocation(line: 12, column: 15, scope: !42)
!48 = !DILocation(line: 12, column: 5, scope: !42)
!49 = !DILocation(line: 14, column: 5, scope: !42)
