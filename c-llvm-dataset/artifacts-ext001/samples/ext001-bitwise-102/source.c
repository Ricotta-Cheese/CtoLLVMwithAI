_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc << 2u) ^ (140955866u ^ 1u)));
    acc = (acc ^ x);
    acc = (acc ^ ((1u ^ y) ^ acc));
    return acc;
}
