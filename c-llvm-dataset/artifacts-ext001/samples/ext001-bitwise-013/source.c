_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (3u << 23u));
    acc = (acc ^ (((x | y) >> 7u) >> 27u));
    acc = (acc ^ (y & (y >> 2u)));
    acc = (acc ^ ((acc & 16u) & acc));
    return acc;
}
