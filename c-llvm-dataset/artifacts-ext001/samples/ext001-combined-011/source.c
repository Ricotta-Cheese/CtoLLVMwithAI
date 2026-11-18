_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 32u) == 0u)) {
            acc = (acc ^ (((16u & y) & (y << 25u)) << 17u));
        } else {
            acc = (acc ^ (x & 7u));
            acc = (acc ^ (acc << 17u));
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (0u >> 18u));
    } else {
        acc = (acc ^ 2u);
        acc = (acc ^ (3u * 16u));
    }
    return acc;
}
