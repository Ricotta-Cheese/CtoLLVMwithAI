_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ ((15u + x) ^ (acc ^ acc)));
        if (((((x ^ y) ^ i) & 8u) == 0u)) {
            acc = (acc ^ (((1880095775u << 9u) << 22u) & ((x >> 16u) * (x ^ 31u))));
        } else {
            acc = (acc ^ (x >> 24u));
            acc = (acc ^ (x | 31u));
        }
    }
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (y + acc));
    } else {
        acc = (acc ^ (((y << 20u) - (4294967295u << 6u)) ^ ((x << 10u) - y)));
        acc = (acc ^ y);
    }
    return acc;
}
