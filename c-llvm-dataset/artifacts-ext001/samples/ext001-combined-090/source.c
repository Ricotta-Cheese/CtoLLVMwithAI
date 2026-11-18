_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y ^ y) & (i >> 16u)) >> 24u));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ ((y >> 19u) ^ (16u * 3713082112u)));
        } else {
            acc = (acc ^ (i >> 31u));
            acc = (acc ^ (acc - 15u));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (((y | y) - (y * y)) & ((x - x) - x)));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (acc * y));
    }
    return acc;
}
