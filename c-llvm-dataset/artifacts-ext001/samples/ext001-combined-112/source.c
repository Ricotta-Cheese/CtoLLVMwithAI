_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc - acc) | (i ^ acc)) + ((y & x) & (x >> 1u))));
        acc = (acc ^ (x >> 11u));
        if (((((x ^ y) ^ i) & 64u) == 0u)) {
            acc = (acc ^ (((3u | i) - (acc | 2314676777u)) & (x | (acc & x))));
            acc = (acc ^ (acc + 2854260923u));
        } else {
            acc = (acc ^ ((x - (x & i)) & i));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ 0u);
    } else {
        acc = (acc ^ (3u + y));
    }
    return acc;
}
