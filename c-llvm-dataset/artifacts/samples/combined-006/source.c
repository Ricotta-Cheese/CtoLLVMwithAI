_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((16u - x) - (x >> 14u)) << 0u));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ (((i ^ i) << 23u) * ((7u ^ i) | (i >> 3u))));
        } else {
            acc = (acc ^ (i + y));
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (7u | x));
        acc = (acc ^ (1u + 2u));
    } else {
        acc = (acc ^ (acc & y));
    }
    return acc;
}
