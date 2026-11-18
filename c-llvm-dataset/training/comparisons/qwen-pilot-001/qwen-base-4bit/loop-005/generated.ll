#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    unsigned int x = 0;
    unsigned int y = 0;
    if (argc > 1) {
        x = strtoul(argv[1], NULL, 10);
    }
    if (argc > 2) {
        y = strtoul(argv[2], NULL, 10);
    }
    unsigned int result = compute(x, y);
    printf("Result: %u\n", result);
    return 0;
}