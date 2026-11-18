_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((0u ^ x) ^ (acc ^ y)));
    acc = (acc ^ (((acc << 30u) << 8u) >> 22u));
    return acc;
}
