_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ ((31u + acc) >> 1u));
        acc = (acc ^ ((acc >> 6u) * (x << 17u)));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ ((acc - y) & (y >> 20u)));
    }
    acc = (acc ^ 16u);
    return acc;
}
