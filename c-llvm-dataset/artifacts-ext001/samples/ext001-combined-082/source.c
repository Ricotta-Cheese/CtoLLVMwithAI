_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y ^ (16u - 1u)));
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ 7u);
            acc = (acc ^ ((acc - 31u) & (x & i)));
        } else {
            acc = (acc ^ (0u + y));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (((x << 27u) * y) - (y + x)));
    } else {
        acc = (acc ^ (x * x));
        acc = (acc ^ (((x & acc) >> 11u) ^ 1241248643u));
    }
    return acc;
}
