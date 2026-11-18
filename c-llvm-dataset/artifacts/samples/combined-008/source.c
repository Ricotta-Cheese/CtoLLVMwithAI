_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (31u - 1u));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ (acc | y));
        } else {
            acc = (acc ^ ((acc >> 5u) - (0u - (x * y))));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ (acc | 2u));
    } else {
        acc = (acc ^ ((acc + (x << 25u)) & (16u >> 30u)));
        acc = (acc ^ (y - x));
    }
    return acc;
}
