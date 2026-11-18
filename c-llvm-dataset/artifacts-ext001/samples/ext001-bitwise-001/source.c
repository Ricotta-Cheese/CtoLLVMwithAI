_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((acc >> 15u) >> 11u) & ((acc >> 20u) >> 16u)));
    acc = (acc ^ x);
    acc = (acc ^ (7u | 31u));
    return acc;
}
