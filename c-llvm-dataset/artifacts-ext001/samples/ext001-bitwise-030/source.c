_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((16u >> 10u) << 7u) >> 13u));
    acc = (acc ^ ((acc ^ 0u) & (y ^ y)));
    acc = (acc ^ (y >> 6u));
    acc = (acc ^ (((x | 2u) | (3411200191u & x)) << 12u));
    return acc;
}
