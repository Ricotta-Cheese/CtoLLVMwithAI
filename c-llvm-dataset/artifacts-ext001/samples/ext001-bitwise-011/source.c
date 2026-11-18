_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((y ^ x) << 22u));
    acc = (acc ^ (x | (y | 2u)));
    acc = (acc ^ (((15u ^ 2u) | x) << 21u));
    return acc;
}
