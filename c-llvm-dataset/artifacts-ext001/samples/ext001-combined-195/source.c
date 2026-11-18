_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y - (i << 3u)));
        acc = (acc ^ (((975382217u >> 31u) * (i & i)) << 28u));
        if (((((x ^ y) ^ i) & 16384u) == 0u)) {
            acc = (acc ^ y);
            acc = (acc ^ (((acc | y) | (x & x)) - ((3u + i) << 19u)));
        } else {
            acc = (acc ^ (7u << 21u));
            acc = (acc ^ ((acc & acc) - (i ^ 3302135269u)));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ ((y >> 16u) >> 4u));
    } else {
        acc = (acc ^ (264020948u << 28u));
    }
    return acc;
}
