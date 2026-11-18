_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((y ^ y) ^ (2u & y)));
    acc = (acc ^ (y | x));
    acc = (acc ^ y);
    acc = (acc ^ (acc << 24u));
    return acc;
}
