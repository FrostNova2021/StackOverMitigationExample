
#include <stdlib.h>
#include <stdio.h>

#define BUFFER_MAX (0x10)


typedef struct {
    int a;
    char buffer[BUFFER_MAX];
    int b;
    int c;
} no_check;

typedef struct {
    int a;
    char* buffer;
    int b;
    int c;
} check;


int main() {
    no_check test_obj1 = {0};
    check    test_obj2 = {};

    printf("no crash!\n");
    test_obj1.buffer[BUFFER_MAX] = 0xFF;

    printf("crash!\n");
    test_obj2.buffer = malloc(BUFFER_MAX);
    test_obj2.buffer[BUFFER_MAX] = 0xFF;

    return 0;
}
