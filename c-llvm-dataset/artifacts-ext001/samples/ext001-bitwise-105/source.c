_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ y);
    acc = (acc ^ ((x >> 3u) >> 13u));
    acc = (acc ^ (0u | (16u >> 30u)));
    return acc;
}
