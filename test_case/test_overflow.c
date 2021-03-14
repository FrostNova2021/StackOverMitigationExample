
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
