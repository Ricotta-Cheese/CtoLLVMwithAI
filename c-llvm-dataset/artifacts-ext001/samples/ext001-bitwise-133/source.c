_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((acc >> 3u) | y) << 3u));
    acc = (acc ^ (((1u & acc) ^ (x & y)) | (1u << 27u)));
    acc = (acc ^ (((756029824u << 19u) << 5u) & (x ^ acc)));
    acc = (acc ^ y);
    return acc;
}
