#include <stdint.h>
#include <stdio.h>

_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");

unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ ((y & acc) >> 7u));
        acc = (acc ^ (((y << 10u) + (acc - x)) << 5u));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ ((acc << 22u) & (y + acc)));
    return acc;
}