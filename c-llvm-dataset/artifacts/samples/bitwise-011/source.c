_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((x << 7u) ^ (x << 26u)) ^ (x >> 19u)));
    acc = (acc ^ y);
    acc = (acc ^ (((y ^ 3u) << 19u) ^ 3u));
    acc = (acc ^ (x << 14u));
    return acc;
}
