_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc << 2u) & (y + y)));
        acc = (acc ^ (acc - y));
        if (((((x ^ y) ^ i) & 1u) == 0u)) {
            acc = (acc ^ ((x << 23u) - (i & i)));
            acc = (acc ^ ((4294967295u | (acc << 11u)) ^ ((31u ^ i) << 15u)));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (((3u >> 29u) * (x + acc)) >> 8u));
    } else {
        acc = (acc ^ (y ^ 31u));
        acc = (acc ^ ((4294967295u - acc) >> 7u));
    }
    return acc;
}
