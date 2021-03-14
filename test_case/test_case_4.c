
#include <stdio.h>


int main(void) {
    char* buffer = malloc(10);

    printf("crash!\n");
    buffer[10] = 0xFF;

    return 0;
}
