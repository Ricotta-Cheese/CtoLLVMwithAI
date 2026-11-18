#include <stdint.h>
#include <stdio.h>

_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");

unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + (y + acc));
    acc = (acc + ((y - 31u) - (y - y)));
    acc = (acc * (((16u * x) + (x - x)) - ((x + y) + (acc - x))));
    return acc;
}