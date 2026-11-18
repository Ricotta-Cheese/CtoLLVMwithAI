_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (0u >> 10u));
        acc = (acc ^ (x | acc));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ ((acc * 7u) | (i >> 0u)));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ 1u);
    } else {
        acc = (acc ^ (x - x));
        acc = (acc ^ (y >> 12u));
    }
    return acc;
}
