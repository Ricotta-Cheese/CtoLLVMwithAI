_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ ((31u ^ 31u) >> 23u));
        acc = (acc ^ ((y ^ (x * y)) + ((y >> 26u) | 0u)));
    }
    acc = (acc ^ (y & 31u));
    return acc;
}
