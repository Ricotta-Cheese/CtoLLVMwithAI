_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ (0u >> 12u));
        acc = (acc ^ ((2u + 15u) + (acc << 16u)));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (7u * acc));
            acc = (acc ^ ((0u << 11u) - (i >> 16u)));
        } else {
            acc = (acc ^ ((31u >> 19u) + (x ^ y)));
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (y + y));
    } else {
        acc = (acc ^ (((y ^ x) << 2u) << 17u));
        acc = (acc ^ (x ^ (acc - acc)));
    }
    return acc;
}
