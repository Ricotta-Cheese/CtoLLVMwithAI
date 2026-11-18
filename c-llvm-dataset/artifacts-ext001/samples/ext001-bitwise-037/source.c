_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (15u >> 12u));
    acc = (acc ^ (((2u | x) << 24u) & 31u));
    acc = (acc ^ (acc | 1u));
    acc = (acc ^ ((acc << 18u) & (acc & x)));
    return acc;
}
