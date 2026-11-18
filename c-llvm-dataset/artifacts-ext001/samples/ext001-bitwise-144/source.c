_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((acc | 7u) >> 13u) | (acc | acc)));
    acc = (acc ^ (2u ^ y));
    acc = (acc ^ (0x2u ^ 7u));
    return acc;
}
