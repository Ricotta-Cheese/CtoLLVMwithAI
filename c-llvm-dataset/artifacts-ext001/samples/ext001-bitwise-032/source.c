_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((y << 9u) | (acc ^ acc)));
    acc = (acc ^ ((acc >> 14u) & y));
    acc = (acc ^ ((3u >> 17u) & 16u));
    return acc;
}
