_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 64u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ y);
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (acc + 1u));
        acc = (acc ^ ((x ^ acc) >> 3u));
    } else {
        acc = (acc ^ ((3u >> 3u) + (4294967295u ^ x)));
        acc = (acc ^ (acc | 3u));
    }
    return acc;
}
