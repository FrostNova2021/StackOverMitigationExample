
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

uint32_t __sancov_current_all_guard_count = 0;
uint32_t __sancov_current_execute_guard_count = 0;

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
  if (!*guard) return;
  void *PC = __builtin_return_address(0);
  char PcDescr[1024];
    
  __sanitizer_symbolize_pc(PC, "%p %F %L", PcDescr, sizeof(PcDescr));
  printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
  ++__sancov_current_execute_guard_count;
}

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,uint32_t *stop) {
    int index = 0;

    for (uint32_t *p = start;p <= stop;++p)
        *p = ++index;

    __sancov_current_all_guard_count = (stop - start);

    printf("start %X stop %X\n",start,stop);
    printf("Sanitizer All Coverage edges: 0x%X \n",__sancov_current_all_guard_count);
}

int function1(int a) {
    if (1 == a)
        return 0;

    return 1;
}

int function2() {
    return -1;
}

int main() {
    if (rand() % 2)
        function1(rand() % 3);
    else
        function2();

    printf("Coverage Rate:%.2f% (%d/%d)\n",
        __sancov_current_execute_guard_count,
        __sancov_current_all_guard_count,
        ((float)__sancov_current_execute_guard_count/(float)__sancov_current_all_guard_count) * 100);

    return 0;
}
