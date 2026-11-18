_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ ((1u << 1u) | (x >> 30u)));
    } else {
        acc = (acc ^ (((x + acc) - x) ^ ((acc >> 17u) | (x + y))));
    }
    acc = (acc ^ (acc << 6u));
    return acc;
}
