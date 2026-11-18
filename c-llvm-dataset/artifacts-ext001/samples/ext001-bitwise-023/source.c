_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ acc);
    acc = (acc ^ (((y ^ 2u) & (x ^ 0u)) ^ ((acc << 17u) << 3u)));
    acc = (acc ^ ((15u >> 17u) >> 4u));
    return acc;
}
