_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((2u | y) << 2u) | ((acc >> 3u) << 22u)));
    acc = (acc ^ x);
    return acc;
}
