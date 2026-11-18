_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ (4294967295u << 3u));
        } else {
            acc = (acc ^ (i >> 2u));
            acc = (acc ^ (((16u - i) & (y & x)) + ((acc | y) & (x | x))));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ (((x ^ acc) >> 23u) << 20u));
        acc = (acc ^ ((0u << 13u) | (0u + x)));
    } else {
        acc = (acc ^ 15u);
    }
    return acc;
}
