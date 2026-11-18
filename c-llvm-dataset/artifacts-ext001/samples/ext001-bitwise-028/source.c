_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ 3u);
    acc = (acc ^ (((1u << 30u) >> 4u) & (acc << 15u)));
    acc = (acc ^ 0u);
    acc = (acc ^ x);
    return acc;
}
