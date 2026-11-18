_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (acc | y));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (acc * 0u));
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (((3u | 15u) << 16u) >> 4u));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (y & x));
    } else {
        acc = (acc ^ (((y + x) * (15u >> 14u)) - 2u));
        acc = (acc ^ acc);
    }
    return acc;
}
