_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (y >> 12u));
    acc = (acc ^ (7u ^ 3u));
    acc = (acc ^ (((0u | 31u) | (acc ^ y)) | ((y ^ 0u) | (x & acc))));
    acc = (acc ^ ((3632682255u << 5u) | (x ^ y)));
    return acc;
}
