_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc & x) << 30u));
    acc = (acc ^ (acc ^ (0u | 15u)));
    acc = (acc ^ (y ^ x));
    acc = (acc ^ (((acc >> 30u) & (y ^ y)) & 31u));
    return acc;
}
