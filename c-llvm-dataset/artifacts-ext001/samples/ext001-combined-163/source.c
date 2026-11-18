_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc + x) + (i >> 19u)) ^ ((acc + 4294967295u) | (31u - i))));
        acc = (acc ^ (((y - i) - x) | ((acc << 27u) ^ (y * i))));
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (((acc >> 10u) >> 19u) >> 29u));
            acc = (acc ^ (((2u >> 15u) & i) * ((x + i) * (i * 7u))));
        } else {
            acc = (acc ^ x);
            acc = (acc ^ (((2u ^ x) >> 22u) >> 6u));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ ((2u ^ y) << 7u));
    } else {
        acc = (acc ^ (16u << 30u));
    }
    return acc;
}
