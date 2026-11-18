_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((y >> 2u) >> 20u) >> 2u));
    acc = (acc ^ (((1u | acc) & (acc << 4u)) | ((31u & acc) >> 6u)));
    return acc;
}
