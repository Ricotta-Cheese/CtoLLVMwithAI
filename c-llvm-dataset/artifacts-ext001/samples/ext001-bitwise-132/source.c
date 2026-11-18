_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((x ^ y) & (4294967295u >> 29u)));
    acc = (acc ^ ((x >> 30u) >> 19u));
    acc = (acc ^ ((3u >> 23u) << 17u));
    return acc;
}
