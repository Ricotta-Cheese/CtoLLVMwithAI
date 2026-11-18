_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ x);
    acc = (acc ^ (((y >> 22u) << 8u) >> 28u));
    acc = (acc ^ (((acc ^ y) & y) | ((31u ^ 2u) ^ (y ^ acc))));
    acc = (acc ^ ((acc << 20u) | (acc & 7u)));
    return acc;
}
