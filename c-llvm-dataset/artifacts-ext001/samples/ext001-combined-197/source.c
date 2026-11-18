_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ y);
        if (((((x ^ y) ^ i) & 1u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ ((acc << 2u) & y));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ ((acc | y) >> 2u));
        acc = (acc ^ ((0u << 29u) >> 14u));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
