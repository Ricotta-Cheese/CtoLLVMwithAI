_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((acc | y) >> 18u) | ((x << 28u) | (acc << 24u))));
    acc = (acc ^ x);
    acc = (acc ^ (((x & x) & y) >> 0u));
    acc = (acc ^ ((x >> 9u) | (acc ^ 2u)));
    return acc;
}
