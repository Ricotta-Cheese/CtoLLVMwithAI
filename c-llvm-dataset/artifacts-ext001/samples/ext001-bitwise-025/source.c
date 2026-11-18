_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((acc >> 7u) & (x >> 24u)));
    acc = (acc ^ 0u);
    acc = (acc ^ x);
    acc = (acc ^ (x >> 1u));
    return acc;
}
