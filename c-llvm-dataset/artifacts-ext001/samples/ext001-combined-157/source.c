_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (15u & (acc >> 27u)));
        acc = (acc ^ i);
        acc = (acc ^ ((x + acc) << 23u));
        if (((((x ^ y) ^ i) & 32u) == 0u)) {
            acc = (acc ^ (i & i));
        } else {
            acc = (acc ^ ((x >> 3u) * (y | 2u)));
            acc = (acc ^ (x - x));
        }
    }
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (((acc * x) - x) >> 31u));
        acc = (acc ^ ((31u * 3664241425u) + (x ^ 3u)));
    } else {
        acc = (acc ^ (((x ^ y) ^ (acc ^ 1u)) >> 27u));
    }
    return acc;
}
