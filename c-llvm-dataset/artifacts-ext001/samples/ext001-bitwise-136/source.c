_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc << 23u) >> 13u));
    acc = (acc ^ ((7u >> 29u) >> 22u));
    acc = (acc ^ ((y >> 11u) | y));
    acc = (acc ^ 1u);
    return acc;
}
