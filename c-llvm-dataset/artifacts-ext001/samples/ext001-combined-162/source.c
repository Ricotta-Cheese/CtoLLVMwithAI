_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y & 0u));
        acc = (acc ^ ((x >> 5u) & ((0u >> 0u) & (acc & acc))));
        acc = (acc ^ ((y << 22u) & (y << 2u)));
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (x ^ 1u));
        } else {
            acc = (acc ^ ((i | y) | (i >> 18u)));
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (x + (acc - (y >> 10u))));
    } else {
        acc = (acc ^ (y << 26u));
        acc = (acc ^ (0u >> 2u));
    }
    return acc;
}
