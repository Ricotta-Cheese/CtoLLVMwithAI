_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((y | acc) & (x ^ x)) | ((acc & x) >> 18u)));
    acc = (acc ^ (0u | x));
    acc = (acc ^ (y << 14u));
    acc = (acc ^ (y << 12u));
    return acc;
}
