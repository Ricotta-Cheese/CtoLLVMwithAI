_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((acc << 8u) >> 13u) & ((x | y) ^ (y ^ y))));
    acc = (acc ^ ((3287442765u | 3u) & (x ^ x)));
    acc = (acc ^ (acc & (0u & y)));
    return acc;
}
