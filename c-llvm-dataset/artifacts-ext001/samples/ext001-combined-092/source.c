_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y - acc) ^ (y & acc)) - i));
        acc = (acc ^ (x >> 8u));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ (3u | ((31u << 15u) << 1u)));
        } else {
            acc = (acc ^ ((x & (y - acc)) << 12u));
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ ((acc << 3u) << 10u));
    } else {
        acc = (acc ^ (2423461698u << 10u));
    }
    return acc;
}
