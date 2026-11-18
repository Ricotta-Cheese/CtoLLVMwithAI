_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (16u >> 10u));
    acc = (acc ^ ((x & x) << 17u));
    acc = (acc ^ ((x | y) >> 13u));
    return acc;
}
