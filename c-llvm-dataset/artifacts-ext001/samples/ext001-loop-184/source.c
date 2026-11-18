_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i & y) >> 2u) << 13u));
        acc = (acc ^ (((acc - i) * y) ^ ((x | 2938806726u) & 2u)));
        acc = (acc ^ (i * i));
    }
    return acc;
}
