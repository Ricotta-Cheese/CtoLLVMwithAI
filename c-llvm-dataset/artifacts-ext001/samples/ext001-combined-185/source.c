_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (x * 7u));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ (((x + 15u) * x) << 4u));
        } else {
            acc = (acc ^ ((acc | i) + (3u ^ acc)));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ ((2u * acc) << 20u));
    } else {
        acc = (acc ^ ((acc + 16u) & (acc - y)));
        acc = (acc ^ y);
    }
    return acc;
}
