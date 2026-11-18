_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (1835133355u | x));
    acc = (acc ^ (((y & x) << 23u) & ((acc | 1u) & (x & 31u))));
    return acc;
}
