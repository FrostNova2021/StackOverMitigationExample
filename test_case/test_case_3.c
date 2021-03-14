
#include <stdio.h>


int main(void) {
    char buffer[10] = {0};

    printf("no crash!\n");
    buffer[0x1001] = 0xFF;

    printf("crash!\n");
    buffer[10] = 0xFF;

    return 0;
}
