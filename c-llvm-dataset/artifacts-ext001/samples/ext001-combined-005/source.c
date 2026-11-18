_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y >> 21u) - (y - 15u)));
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (x - 2u));
        } else {
            acc = (acc ^ acc);
            acc = (acc ^ ((7u ^ i) * (acc << 1u)));
        }
    }
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (acc | acc));
        acc = (acc ^ (((x ^ 15u) * (acc & acc)) + ((1782510535u - x) - (acc & acc))));
    } else {
        acc = (acc ^ ((acc * y) >> 17u));
    }
    return acc;
}
