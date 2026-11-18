_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((31u ^ i) & (acc + 3u)));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (((i ^ 0u) | y) >> 20u));
        } else {
            acc = (acc ^ (15u ^ i));
            acc = (acc ^ (((0u >> 15u) >> 10u) >> 1u));
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (((y | 31u) - 16u) - acc));
    } else {
        acc = (acc ^ 15u);
        acc = (acc ^ x);
    }
    return acc;
}
