_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y & (3u - (acc << 10u))));
        if (((((x ^ y) ^ i) & 2048u) == 0u)) {
            acc = (acc ^ i);
            acc = (acc ^ (y * ((y + 15u) + (x - acc))));
        } else {
            acc = (acc ^ (((16u ^ y) + (y & y)) & ((i >> 15u) & (i | y))));
            acc = (acc ^ ((3u + i) + (y ^ acc)));
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((acc << 1u) << 19u));
    } else {
        acc = (acc ^ (acc & x));
        acc = (acc ^ (((acc * x) >> 0u) & ((acc | y) - (x - acc))));
    }
    return acc;
}
