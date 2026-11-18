_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (((y - y) + (x & y)) >> 24u));
    } else {
        acc = (acc ^ (x - 2u));
        acc = (acc ^ ((16u * 1u) | (7u - 0u)));
    }
    acc = (acc ^ x);
    return acc;
}
