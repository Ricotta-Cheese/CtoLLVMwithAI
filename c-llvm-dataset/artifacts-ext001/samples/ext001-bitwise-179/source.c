_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((y >> 23u) << 24u));
    acc = (acc ^ (acc >> 7u));
    acc = (acc ^ ((2u | acc) & (1757898504u ^ x)));
    acc = (acc ^ (y & x));
    return acc;
}
