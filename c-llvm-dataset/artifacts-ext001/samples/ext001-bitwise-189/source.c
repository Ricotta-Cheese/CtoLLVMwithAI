_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc | acc) & y));
    acc = (acc ^ ((acc ^ 15u) << 10u));
    acc = (acc ^ (((y & 2u) & (acc << 26u)) & ((x | 1u) & (acc ^ y))));
    return acc;
}
