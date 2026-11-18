#include <stdint.h>
#include <stdio.h>

_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");

unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (y & y));
    acc = (acc ^ (((y | acc) << 3u) ^ y));
    acc = (acc ^ (acc | (582512324u >> 15u)));
    return acc;
}