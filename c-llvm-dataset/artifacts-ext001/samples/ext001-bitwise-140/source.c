_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (acc & 31u));
    acc = (acc ^ ((x >> 5u) & x));
    acc = (acc ^ ((x & x) | (x >> 18u)));
    acc = (acc ^ (((1u ^ x) ^ (y & y)) << 15u));
    return acc;
}
