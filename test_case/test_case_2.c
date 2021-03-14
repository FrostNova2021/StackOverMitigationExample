
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>

#define CHECK_MEMORY_LEFT_SIZE   (0x8)
#define CHECK_MEMORY_RIGHT_SIZE  (0x8)
#define CHECK_MEMORY_NORMAL_FLAG (0x00)
#define CHECK_MEMORY_FREE_FLAG   (0xFE)
#define CHECK_MEMORY_EXCEPT_FLAG (0xFF)


void* create_check_memory(int buffer_size) {
    int real_buffer_size = 
        CHECK_MEMORY_LEFT_SIZE + CHECK_MEMORY_RIGHT_SIZE + buffer_size;
    char* buffer = malloc(real_buffer_size);

    memset(buffer,CHECK_MEMORY_EXCEPT_FLAG,real_buffer_size);
    memset(&buffer[CHECK_MEMORY_LEFT_SIZE],CHECK_MEMORY_NORMAL_FLAG,buffer_size);

    return buffer;
}

void free_check_memory(void* buffer,int buffer_size) {
    memset(buffer,CHECK_MEMORY_FREE_FLAG,
        CHECK_MEMORY_LEFT_SIZE + CHECK_MEMORY_RIGHT_SIZE +buffer_size);
}

int is_overflow(void* buffer,int offset,int is_write) {
    unsigned char data = ((unsigned char*)buffer)[CHECK_MEMORY_LEFT_SIZE + offset];

    if (CHECK_MEMORY_NORMAL_FLAG != data) {
        switch (data) {
            case CHECK_MEMORY_EXCEPT_FLAG:
                if (is_write)
                    printf(" ==== Write OverFlow !! ====\n");
                else
                    printf(" ==== Read OverFlow !! ====\n");

                break;
            case CHECK_MEMORY_FREE_FLAG:
                printf(" ==== Use After Free !! ====\n");

                break;
            default:
                printf("Unknow Except\n");
        }

        exit(0);
    }

    return 0;
}

int main() {
    char buffer[10] = {0};
    char* shadow_buffer = create_check_memory(sizeof(buffer));

    if (is_overflow(shadow_buffer,5,0))
        exit(0);

    int data = buffer[5];

    printf("Try Crash!\n");

    if (is_overflow(shadow_buffer,10,1))
        exit(0);

    buffer[10] = 'C';

    printf("Oops \n");
    
    free_check_memory(shadow_buffer,sizeof(buffer));

    return 1;
}

