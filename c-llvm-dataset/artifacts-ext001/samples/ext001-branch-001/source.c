_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ ((1u - (0u << 31u)) * ((acc ^ 16u) - (x * x))));
    } else {
        acc = (acc ^ ((x * acc) + (2u - acc)));
    }
    acc = (acc ^ (x | (x ^ 0u)));
    return acc;
}
