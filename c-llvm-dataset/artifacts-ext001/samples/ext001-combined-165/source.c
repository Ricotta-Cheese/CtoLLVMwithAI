_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i + acc) - (y | y)) >> 5u));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ ((15u * (i >> 22u)) * ((acc + x) + (2u * 31u))));
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (x << 7u));
    } else {
        acc = (acc ^ (7u << 29u));
        acc = (acc ^ x);
    }
    return acc;
}
