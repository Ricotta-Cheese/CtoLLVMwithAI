_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i >> 7u));
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ 3u);
            acc = (acc ^ ((i & acc) * i));
        } else {
            acc = (acc ^ (((i * i) | (i << 31u)) >> 19u));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ ((16u << 9u) << 23u));
    } else {
        acc = (acc ^ ((acc + 2u) | (16u & acc)));
    }
    return acc;
}
