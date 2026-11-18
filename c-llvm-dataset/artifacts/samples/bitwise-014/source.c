_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((31u | 1u) ^ (x | y)));
    acc = (acc ^ (x >> 22u));
    acc = (acc ^ ((y & x) ^ (acc & acc)));
    acc = (acc ^ y);
    return acc;
}
