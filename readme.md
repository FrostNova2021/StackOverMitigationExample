
## Example


Source Code:

```c


#include <memory.h>
#include <stdlib.h>
#include <stdio.h>

#define BUFFER_SIZE  (0x10)
#define OVERFLOW_MEM (0x8)


int global_value = 2;
long long global_value_64 = 2;

void trigger(void) {
    char buffer[BUFFER_SIZE] = {0};

    memset(buffer,0xFF,BUFFER_SIZE * 2);
}

int main() {
    int test_v = global_value;
    printf("Try Crash!\n");
    trigger();
    printf("Oh no\n");

    return 0;
}


```

Output:

```sh

ubuntu@ubuntu-virtual-machine:~/Desktop/instrument_note$ /home/ubuntu/Desktop/vm_qemu/llvm/llvm_make_mitigation/bin/clang  ./test_overflow.c -o ./test_overflow_stack && ./test_overflow_stack 
./test_overflow.c:21:19: warning: format specifies type 'unsigned int' but the argument has type 'time_t' (aka 'long') [-Wformat]
    printf("%X\n",time(NULL));
            ~~    ^~~~~~~~~~
            %lX
1 warning generated.
604259AC
Try Crash!
Oh no
ubuntu@ubuntu-virtual-machine:~/Desktop/instrument_note$ /home/ubuntu/Desktop/vm_qemu/llvm/llvm_make_mitigation/bin/clang -fsanitize=stack ./test_overflow.c -g -o ./test_overflow && ./test_overflow 
./test_overflow.c:16:5: warning: 'memset' will always overflow; destination buffer has size 16, but size argument is 32 [-Wfortify-source]
    memset(buffer,0xFF,BUFFER_SIZE * 2);
    ^
ExitFunction=7DD8370 
TimeFunction=7DD83C0 
RandFunction=7DD81E0 
SRandFunction=7DD83C0 
instrumentModule OK
1 warning generated.
Try Crash!
ubuntu@ubuntu-virtual-machine:~/Desktop/instrument_note$

```

## Example LLVM-IR

No-Mitigation LLVM-IR:

```llvm

; ModuleID = './test_overflow.c'
source_filename = "./test_overflow.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global_value = dso_local global i32 2, align 4
@global_value_64 = dso_local global i64 2, align 8
@.str = private unnamed_addr constant [12 x i8] c"Try Crash!\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"Oh no\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @trigger() #0 {
  %1 = alloca [16 x i8], align 16
  %2 = bitcast [16 x i8]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %2, i8 0, i64 16, i1 false)
  %3 = getelementptr inbounds [16 x i8], [16 x i8]* %1, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* align 16 %3, i8 -1, i64 16, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = load i32, i32* @global_value, align 4
  store i32 %3, i32* %2, align 4
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0))
  call void @trigger()
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn writeonly }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.0.1"}

```

Use Stack Overflow Mitigation LLVM-IR:

```llvm

; ModuleID = './test_overflow.c'
source_filename = "./test_overflow.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global_value = dso_local global i32 2, align 4
@global_value_64 = dso_local global i64 2, align 8
@.str = private unnamed_addr constant [12 x i8] c"Try Crash!\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"Oh no\0A\00", align 1
@stack_cookie_seed = global i64 61488, align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 1, void ()* @__StackOverflowMitigation_Ctor, i8* null }]

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @trigger() #0 {
  %1 = alloca i64, align 8
  %2 = load i64, i64* @stack_cookie_seed, align 8
  store i64 %2, i64* %1, align 8
  %3 = alloca [16 x i8], align 16
  %4 = bitcast [16 x i8]* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %4, i8 0, i64 16, i1 false)
  %5 = getelementptr inbounds [16 x i8], [16 x i8]* %3, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* align 16 %5, i8 -1, i64 32, i1 false)
  %6 = load i64, i64* %1, align 8
  %7 = load i64, i64* @stack_cookie_seed, align 8
  %8 = icmp ne i64 %6, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  call void @exit(i64 1)
  br label %10

10:                                               ; preds = %0, %9
  ret void
}

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i64, align 8
  %2 = load i64, i64* @stack_cookie_seed, align 8
  store i64 %2, i64* %1, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  %5 = load i32, i32* @global_value, align 4
  store i32 %5, i32* %4, align 4
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0))
  call void @trigger()
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
  %8 = load i64, i64* %1, align 8
  %9 = load i64, i64* @stack_cookie_seed, align 8
  %10 = icmp ne i64 %8, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  call void @exit(i64 1)
  br label %12

12:                                               ; preds = %0, %11
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #2

define internal void @__StackOverflowMitigation_Init() {
  %1 = alloca i64, align 8
  %2 = call i32 @time(i64 0)
  store i32 %2, i64* @stack_cookie_seed, align 4
  ret void
}

define internal void @__StackOverflowMitigation_Ctor() {
  call void @__StackOverflowMitigation_Init()
  ret void
}

declare void @exit(i64)

declare i32 @time(i64)

declare i32 @rand()

declare i32 @srand(i64)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn writeonly }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.0.1"}

```

