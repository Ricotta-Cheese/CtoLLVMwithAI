_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc - acc) * (y * x)) << 27u));
        acc = (acc ^ ((0u + 16u) - (16u >> 5u)));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ (acc >> 17u));
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (((acc >> 16u) - (acc & 15u)) - (i * (4294967295u >> 20u))));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (((y >> 7u) >> 9u) * ((acc - x) << 18u)));
    } else {
        acc = (acc ^ y);
    }
    return acc;
}
