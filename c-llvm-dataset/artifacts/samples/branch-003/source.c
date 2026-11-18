_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (acc | acc));
    } else {
        acc = (acc ^ ((y - x) | (7u << 16u)));
        acc = (acc ^ ((16u ^ x) | (y + y)));
    }
    acc = (acc ^ ((y >> 12u) * (y >> 2u)));
    return acc;
}
