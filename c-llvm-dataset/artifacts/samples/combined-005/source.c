_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i ^ y) >> 10u));
        acc = (acc ^ ((31u >> 10u) ^ x));
        acc = (acc ^ (x & ((7u - i) ^ (acc - 31u))));
        if (((((x ^ y) ^ i) & 1u) == 0u)) {
            acc = (acc ^ ((x << 17u) - (i << 6u)));
            acc = (acc ^ (i << 12u));
        } else {
            acc = (acc ^ ((acc ^ acc) | (7u * acc)));
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (acc * acc));
        acc = (acc ^ (y << 10u));
    } else {
        acc = (acc ^ (0u ^ acc));
    }
    return acc;
}
