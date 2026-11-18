_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x >> 23u));
        acc = (acc ^ 3u);
        acc = (acc ^ (((acc << 20u) << 29u) - ((acc | y) & 3u)));
        if (((((x ^ y) ^ i) & 134217728u) == 0u)) {
            acc = (acc ^ (x + 1u));
        } else {
            acc = (acc ^ (16u | ((y & 2u) >> 13u)));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ ((acc - (acc | y)) << 28u));
        acc = (acc ^ (x | x));
    }
    return acc;
}
