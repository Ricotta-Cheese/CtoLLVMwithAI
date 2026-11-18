_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((acc << 29u) & (x >> 15u)));
    acc = (acc ^ (((y << 14u) >> 16u) | ((y ^ acc) << 3u)));
    return acc;
}
