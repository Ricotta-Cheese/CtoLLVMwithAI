_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((y ^ 15u) << 11u) & (x & (x | 2755221959u))));
    acc = (acc ^ 1u);
    acc = (acc ^ ((x | y) >> 26u));
    return acc;
}
