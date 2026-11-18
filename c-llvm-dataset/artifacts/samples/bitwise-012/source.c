_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (16u ^ x));
    acc = (acc ^ 7u);
    acc = (acc ^ ((1285554107u | 31u) ^ (y ^ 16u)));
    acc = (acc ^ y);
    return acc;
}
