_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((x << 1u) ^ (x | 2u)) << 1u));
    acc = (acc ^ ((y << 1u) << 2u));
    acc = (acc ^ (acc ^ 7u));
    acc = (acc ^ (y & (acc & x)));
    return acc;
}
