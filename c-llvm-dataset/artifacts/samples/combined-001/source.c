_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ acc);
            acc = (acc ^ 31u);
        } else {
            acc = (acc ^ (acc * 7u));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (y << 7u));
    }
    return acc;
}
