_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((31u * i) - (y & y)));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (x & i));
        } else {
            acc = (acc ^ ((y & 0u) * (i >> 18u)));
            acc = (acc ^ (((x & acc) - (16u >> 17u)) - ((15u + x) | (0u * x))));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ (acc - x));
    } else {
        acc = (acc ^ ((acc ^ acc) * 7u));
    }
    return acc;
}
