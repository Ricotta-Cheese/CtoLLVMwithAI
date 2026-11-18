_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (y & (16u & x)));
    acc = (acc ^ x);
    acc = (acc ^ y);
    acc = (acc ^ ((x << 11u) << 21u));
    return acc;
}
