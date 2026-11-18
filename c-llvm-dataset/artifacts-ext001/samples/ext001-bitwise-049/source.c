_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc & x) >> 9u));
    acc = (acc ^ (x >> 5u));
    acc = (acc ^ acc);
    acc = (acc ^ ((x ^ x) | (y << 27u)));
    return acc;
}
