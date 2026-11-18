_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y >> 19u) + (x >> 2u)) * ((i >> 25u) * i)));
        acc = (acc ^ (((i & i) & (x & y)) << 19u));
        acc = (acc ^ ((x >> 25u) ^ x));
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (((i * y) & (x - y)) ^ ((2u >> 10u) ^ (x + i))));
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ 3u);
        acc = (acc ^ (x << 19u));
    } else {
        acc = (acc ^ (acc + x));
    }
    return acc;
}
