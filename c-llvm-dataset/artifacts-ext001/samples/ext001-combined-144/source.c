_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc & x) + (acc | i)));
        acc = (acc ^ ((acc - 0u) >> 27u));
        acc = (acc ^ ((y + 16u) + (acc >> 10u)));
        if (((((x ^ y) ^ i) & 67108864u) == 0u)) {
            acc = (acc ^ (x >> 11u));
        } else {
            acc = (acc ^ ((31u & i) ^ (3u + 31u)));
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (((15u - y) * (x - 0u)) ^ ((x * 0u) - (y - x))));
        acc = (acc ^ ((x & (y ^ y)) ^ (y >> 8u)));
    } else {
        acc = (acc ^ ((1u ^ 3u) | (y ^ acc)));
        acc = (acc ^ (((acc + x) | (acc >> 22u)) & ((y + 4142726196u) << 17u)));
    }
    return acc;
}
