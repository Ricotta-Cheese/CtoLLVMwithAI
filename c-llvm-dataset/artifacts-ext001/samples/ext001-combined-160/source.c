_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y ^ i) + (4294967295u >> 31u)) + ((acc >> 7u) - acc)));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ ((x - i) >> 21u));
            acc = (acc ^ (acc << 29u));
        } else {
            acc = (acc ^ ((acc ^ 7u) ^ x));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (0u * y));
    } else {
        acc = (acc ^ ((15u * y) - (x * y)));
        acc = (acc ^ ((16u + acc) << 6u));
    }
    return acc;
}
