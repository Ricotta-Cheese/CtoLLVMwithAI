_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i - acc) & (acc + 1u)));
        if (((((x ^ y) ^ i) & 67108864u) == 0u)) {
            acc = (acc ^ (31u & acc));
        } else {
            acc = (acc ^ acc);
            acc = (acc ^ (x >> 21u));
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (3u >> 1u));
        acc = (acc ^ 15u);
    } else {
        acc = (acc ^ (x << 5u));
    }
    return acc;
}
