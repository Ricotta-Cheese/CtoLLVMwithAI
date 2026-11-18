_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ ((acc >> 10u) >> 0u));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((7u & y) << 28u));
    }
    acc = (acc ^ ((y >> 9u) << 9u));
    return acc;
}
