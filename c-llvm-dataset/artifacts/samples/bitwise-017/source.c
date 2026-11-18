_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ acc);
    acc = (acc ^ (((31u & x) << 23u) >> 30u));
    acc = (acc ^ y);
    return acc;
}
