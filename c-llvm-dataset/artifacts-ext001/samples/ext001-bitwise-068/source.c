_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((1u | x) >> 7u) & ((y | y) << 26u)));
    acc = (acc ^ ((1u << 14u) << 5u));
    acc = (acc ^ (acc ^ (acc << 26u)));
    return acc;
}
