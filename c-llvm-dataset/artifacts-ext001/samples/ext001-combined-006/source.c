_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y | y) - (x * i)));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ (((1u + y) ^ (x * i)) & ((acc ^ y) + i)));
        } else {
            acc = (acc ^ ((x & x) ^ acc));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (y - 0u));
    } else {
        acc = (acc ^ ((x >> 20u) | (16u & acc)));
    }
    return acc;
}
