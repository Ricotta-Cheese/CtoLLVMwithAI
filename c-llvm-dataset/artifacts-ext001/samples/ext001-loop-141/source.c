_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (x & ((acc | i) | x)));
        acc = (acc ^ (((16u - acc) | (x & acc)) + ((7u + 3230044229u) >> 24u)));
    }
    return acc;
}
