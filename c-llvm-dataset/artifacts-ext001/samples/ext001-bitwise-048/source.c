_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ y);
    acc = (acc ^ 7u);
    acc = (acc ^ (((y | y) | (y & x)) ^ ((acc << 0u) << 3u)));
    acc = (acc ^ ((x ^ (y | acc)) & x));
    return acc;
}
