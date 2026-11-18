_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ 15u);
    acc = (acc ^ (((acc << 20u) << 24u) >> 0u));
    acc = (acc ^ (acc | 90947691u));
    acc = (acc ^ (((x << 9u) << 8u) & ((7u | y) & (y & y))));
    return acc;
}
