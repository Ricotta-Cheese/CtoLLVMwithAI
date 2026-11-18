_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((4294967295u ^ acc) << 22u));
        acc = (acc ^ (((x * acc) >> 15u) - 4294967295u));
        acc = (acc ^ ((7u ^ y) >> 31u));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ (i + 3u));
            acc = (acc ^ (2u - 2u));
        } else {
            acc = (acc ^ ((acc | y) | (31u * x)));
            acc = (acc ^ ((acc & 15u) << 22u));
        }
    }
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (((2u >> 17u) - (y ^ y)) ^ (y | (7u ^ x))));
    } else {
        acc = (acc ^ (x & y));
    }
    return acc;
}
