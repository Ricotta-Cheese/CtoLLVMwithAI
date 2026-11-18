_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x + y) | (i >> 18u)));
        acc = (acc ^ (((139796418u * 2u) << 9u) + ((acc + acc) ^ (16u ^ acc))));
        if (((((x ^ y) ^ i) & 16384u) == 0u)) {
            acc = (acc ^ (i * x));
        } else {
            acc = (acc ^ (((1u * y) | (x | y)) << 1u));
            acc = (acc ^ (((1369565870u >> 3u) & y) << 8u));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ (acc & ((0u - y) ^ (acc << 1u))));
    } else {
        acc = (acc ^ (3u - acc));
    }
    return acc;
}
