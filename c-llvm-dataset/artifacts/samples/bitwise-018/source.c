_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((x >> 6u) & (x << 2u)));
    acc = (acc ^ ((acc >> 8u) >> 6u));
    acc = (acc ^ ((y | 31u) >> 6u));
    return acc;
}
