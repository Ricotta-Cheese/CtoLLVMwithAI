_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (((y ^ y) | (0u | acc)) * (acc - acc)));
    } else {
        acc = (acc ^ 0u);
        acc = (acc ^ ((1u ^ x) * (y * acc)));
    }
    acc = (acc ^ (((y - acc) >> 28u) | (y >> 17u)));
    return acc;
}
