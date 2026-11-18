_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x << 3u) >> 14u));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ ((15u << 18u) - x));
            acc = (acc ^ (((i | 7u) & (i >> 25u)) << 25u));
        } else {
            acc = (acc ^ ((acc ^ 15u) + x));
            acc = (acc ^ ((acc * (acc >> 31u)) * y));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (y & acc));
    } else {
        acc = (acc ^ (7u | x));
        acc = (acc ^ (x & (y & (x - x))));
    }
    return acc;
}
