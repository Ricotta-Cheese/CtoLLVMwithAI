_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x & (acc >> 23u)) ^ ((0u | i) * (i * 2u))));
        acc = (acc ^ (((1922685473u - 4294967295u) * (x & acc)) + ((x ^ 3u) & (0u - 0u))));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ (15u - y));
        } else {
            acc = (acc ^ (acc ^ (3u << 26u)));
            acc = (acc ^ (y - (y << 27u)));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ ((y - acc) >> 8u));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((acc + 7u) & (x - x)));
        acc = (acc ^ (y << 20u));
    }
    return acc;
}
