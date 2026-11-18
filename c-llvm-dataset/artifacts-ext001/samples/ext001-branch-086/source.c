_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ ((acc * (y ^ x)) >> 23u));
        acc = (acc ^ ((y + (acc | x)) << 6u));
    } else {
        acc = (acc ^ (((x | 1u) - (1u | acc)) ^ 2u));
        acc = (acc ^ 2u);
    }
    acc = (acc ^ ((acc | 2u) << 18u));
    return acc;
}
