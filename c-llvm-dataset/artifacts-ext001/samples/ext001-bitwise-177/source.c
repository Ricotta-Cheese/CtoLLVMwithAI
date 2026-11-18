_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc & x) ^ (y ^ 31u)));
    acc = (acc ^ ((7u >> 29u) << 15u));
    return acc;
}
