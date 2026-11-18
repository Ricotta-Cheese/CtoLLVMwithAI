_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ (acc ^ y));
        acc = (acc ^ (((i - acc) | (2u - i)) - ((y >> 28u) | (i | 2u))));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (y >> 19u));
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (((0u - acc) - (acc << 3u)) << 18u));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
