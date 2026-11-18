_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 7u);
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ ((i ^ 3u) | 2u));
            acc = (acc ^ (2u ^ y));
        } else {
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (((y >> 8u) - (2u * 31u)) ^ ((y - 2u) + (y & 31u))));
        acc = (acc ^ (x << 1u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (y & acc));
    }
    return acc;
}
