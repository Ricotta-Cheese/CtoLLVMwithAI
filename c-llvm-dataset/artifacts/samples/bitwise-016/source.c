_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (acc ^ y));
    acc = (acc ^ (((x & y) >> 16u) >> 1u));
    return acc;
}
