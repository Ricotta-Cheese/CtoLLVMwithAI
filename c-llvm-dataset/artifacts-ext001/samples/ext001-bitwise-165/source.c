_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (x | y));
    acc = (acc ^ (y & 7u));
    acc = (acc ^ (((15u >> 22u) >> 6u) & ((y & 0u) & (acc << 6u))));
    return acc;
}
