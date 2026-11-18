_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (y & 0u));
    acc = (acc ^ (y | x));
    acc = (acc ^ (2u ^ acc));
    acc = (acc ^ (y | x));
    return acc;
}
