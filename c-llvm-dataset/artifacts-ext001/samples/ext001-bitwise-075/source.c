_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((x << 15u) & 1u));
    acc = (acc ^ (((y ^ acc) & (x & acc)) | 7u));
    return acc;
}
