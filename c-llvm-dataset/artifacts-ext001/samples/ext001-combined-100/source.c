_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y + (1043161740u - acc)));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ ((acc << 21u) - acc));
        } else {
            acc = (acc ^ (acc | (i & acc)));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (x >> 26u));
    } else {
        acc = (acc ^ ((acc | 3u) << 2u));
    }
    return acc;
}
