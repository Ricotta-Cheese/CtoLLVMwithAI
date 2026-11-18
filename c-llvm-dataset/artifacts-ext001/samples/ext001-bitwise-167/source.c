_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (x << 2u));
    acc = (acc ^ (((2u << 23u) & (acc << 18u)) << 23u));
    return acc;
}
