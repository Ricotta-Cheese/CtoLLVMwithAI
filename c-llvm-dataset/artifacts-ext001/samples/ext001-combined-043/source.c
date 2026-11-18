_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc + x));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ ((2u * y) >> 27u));
        } else {
            acc = (acc ^ (i >> 17u));
            acc = (acc ^ (y + 7u));
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ ((acc + y) >> 17u));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ ((y ^ x) ^ (x | acc)));
        acc = (acc ^ (((acc * x) | 87143702u) - acc));
    }
    return acc;
}
