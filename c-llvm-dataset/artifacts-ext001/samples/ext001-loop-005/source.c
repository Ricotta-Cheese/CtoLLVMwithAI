_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x >> 4u));
        acc = (acc ^ (y | (acc ^ i)));
        acc = (acc ^ ((x & (y << 5u)) | ((y | y) - 31u)));
    }
    return acc;
}
