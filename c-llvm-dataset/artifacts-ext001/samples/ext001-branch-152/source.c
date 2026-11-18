_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ ((2u >> 8u) | (x & 2u)));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((acc >> 21u) + (acc << 17u)));
        acc = (acc ^ (y + x));
    }
    acc = (acc ^ (acc ^ x));
    return acc;
}
