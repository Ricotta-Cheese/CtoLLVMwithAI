_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ y);
    acc = (acc ^ ((2u << 7u) & ((2u & x) | (3u ^ y))));
    acc = (acc ^ (0u | y));
    return acc;
}
