#include <stdint.h>
#include <stdio.h>

_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");

unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y ^ acc));
    }
    return acc;
}

int main() {
    unsigned int x = 10;
    unsigned int y = 5;
    unsigned int result = compute(x, y);
    printf("Result: %u\n", result);
    return 0;
}