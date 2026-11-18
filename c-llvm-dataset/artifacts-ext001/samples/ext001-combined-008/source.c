_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i << 29u) | (acc * y)));
        acc = (acc ^ x);
        acc = (acc ^ (x & (7u + i)));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ ((x >> 1u) - (1u >> 21u)));
            acc = (acc ^ x);
        } else {
            acc = (acc ^ (x & i));
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ ((x + y) * (acc >> 6u)));
    } else {
        acc = (acc ^ (y | 0u));
    }
    return acc;
}
