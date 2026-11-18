_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (((acc ^ x) | (acc * x)) << 1u));
        acc = (acc ^ ((x | acc) ^ (y - 0u)));
    } else {
        acc = (acc ^ (y ^ y));
    }
    acc = (acc ^ ((acc * acc) & (y >> 2u)));
    return acc;
}
