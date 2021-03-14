; ModuleID = './test_case_7.cc'
source_filename = "./test_case_7.cc"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.test_class = type <{ %class.test_virtual, i32, i32, i32, [4 x i8] }>
%class.test_virtual = type { i32 (...)** }

$_ZN10test_classC2Ev = comdat any

$_ZN12test_virtualC2ERKS_ = comdat any

$_ZN12test_virtual3addEii = comdat any

$_ZN12test_virtualC2Ev = comdat any

$_ZN10test_class3addEii = comdat any

$_ZTV10test_class = comdat any

$_ZTS10test_class = comdat any

$_ZTS12test_virtual = comdat any

$_ZTI12test_virtual = comdat any

$_ZTI10test_class = comdat any

$_ZTV12test_virtual = comdat any

@_ZTV10test_class = linkonce_odr dso_local unnamed_addr constant { [3 x i8*] } { [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI10test_class to i8*), i8* bitcast (i32 (%class.test_class*, i32, i32)* @_ZN10test_class3addEii to i8*)] }, comdat, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external dso_local global i8*
@_ZTS10test_class = linkonce_odr dso_local constant [13 x i8] c"10test_class\00", comdat, align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external dso_local global i8*
@_ZTS12test_virtual = linkonce_odr dso_local constant [15 x i8] c"12test_virtual\00", comdat, align 1
@_ZTI12test_virtual = linkonce_odr dso_local constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @_ZTS12test_virtual, i32 0, i32 0) }, comdat, align 8
@_ZTI10test_class = linkonce_odr dso_local constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @_ZTS10test_class, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTI12test_virtual to i8*) }, comdat, align 8
@_ZTV12test_virtual = linkonce_odr dso_local unnamed_addr constant { [3 x i8*] } { [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8* }* @_ZTI12test_virtual to i8*), i8* bitcast (i32 (%class.test_virtual*, i32, i32)* @_ZN12test_virtual3addEii to i8*)] }, comdat, align 8

; Function Attrs: noinline norecurse optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %class.test_class, align 8
  %3 = alloca %class.test_virtual, align 8
  store i32 0, i32* %1, align 4
  call void @_ZN10test_classC2Ev(%class.test_class* %2)
  %4 = bitcast %class.test_class* %2 to %class.test_virtual*
  call void @_ZN12test_virtualC2ERKS_(%class.test_virtual* %3, %class.test_virtual* nonnull align 8 dereferenceable(8) %4) #2
  %5 = call i32 @_ZN12test_virtual3addEii(%class.test_virtual* %3, i32 10, i32 20)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10test_classC2Ev(%class.test_class* %0) unnamed_addr #1 comdat align 2 {
  %2 = alloca %class.test_class*, align 8
  store %class.test_class* %0, %class.test_class** %2, align 8
  %3 = load %class.test_class*, %class.test_class** %2, align 8
  %4 = bitcast %class.test_class* %3 to %class.test_virtual*
  call void @_ZN12test_virtualC2Ev(%class.test_virtual* %4) #2
  %5 = bitcast %class.test_class* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [3 x i8*] }, { [3 x i8*] }* @_ZTV10test_class, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %5, align 8
  %6 = getelementptr inbounds %class.test_class, %class.test_class* %3, i32 0, i32 1
  store i32 1, i32* %6, align 8
  %7 = getelementptr inbounds %class.test_class, %class.test_class* %3, i32 0, i32 2
  store i32 2, i32* %7, align 4
  %8 = getelementptr inbounds %class.test_class, %class.test_class* %3, i32 0, i32 3
  store i32 3, i32* %8, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN12test_virtualC2ERKS_(%class.test_virtual* %0, %class.test_virtual* nonnull align 8 dereferenceable(8) %1) unnamed_addr #1 comdat align 2 {
  %3 = alloca %class.test_virtual*, align 8
  %4 = alloca %class.test_virtual*, align 8
  store %class.test_virtual* %0, %class.test_virtual** %3, align 8
  store %class.test_virtual* %1, %class.test_virtual** %4, align 8
  %5 = load %class.test_virtual*, %class.test_virtual** %3, align 8
  %6 = bitcast %class.test_virtual* %5 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [3 x i8*] }, { [3 x i8*] }* @_ZTV12test_virtual, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZN12test_virtual3addEii(%class.test_virtual* %0, i32 %1, i32 %2) unnamed_addr #1 comdat align 2 {
  %4 = alloca %class.test_virtual*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %class.test_virtual* %0, %class.test_virtual** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %class.test_virtual*, %class.test_virtual** %4, align 8
  %8 = load i32, i32* %5, align 4
  %9 = load i32, i32* %6, align 4
  %10 = add nsw i32 %8, %9
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN12test_virtualC2Ev(%class.test_virtual* %0) unnamed_addr #1 comdat align 2 {
  %2 = alloca %class.test_virtual*, align 8
  store %class.test_virtual* %0, %class.test_virtual** %2, align 8
  %3 = load %class.test_virtual*, %class.test_virtual** %2, align 8
  %4 = bitcast %class.test_virtual* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [3 x i8*] }, { [3 x i8*] }* @_ZTV12test_virtual, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZN10test_class3addEii(%class.test_class* %0, i32 %1, i32 %2) unnamed_addr #1 comdat align 2 {
  %4 = alloca %class.test_class*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %class.test_class* %0, %class.test_class** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %class.test_class*, %class.test_class** %4, align 8
  %8 = load i32, i32* %5, align 4
  %9 = load i32, i32* %6, align 4
  %10 = add nsw i32 %8, %9
  ret i32 %10
}

attributes #0 = { noinline norecurse optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.0.0-2"}
