_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y ^ acc));
        acc = (acc ^ (((y | 2u) - (x << 3u)) | ((0u ^ y) >> 1u)));
        acc = (acc ^ ((7u - i) + y));
    }
    return acc;
}
