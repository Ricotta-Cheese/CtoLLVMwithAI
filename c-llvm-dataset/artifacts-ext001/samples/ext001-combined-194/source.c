_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc - acc) << 10u) | ((y >> 12u) - 7u)));
        acc = (acc ^ (((x << 6u) + (i - y)) >> 21u));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ (15u >> 20u));
        } else {
            acc = (acc ^ (i + (y - 2u)));
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (y >> 12u));
    }
    return acc;
}
