_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ 31u);
    } else {
        acc = (acc ^ ((y >> 7u) - (acc ^ 3118101345u)));
        acc = (acc ^ y);
    }
    acc = (acc ^ (((acc * x) ^ 7u) >> 30u));
    return acc;
}
