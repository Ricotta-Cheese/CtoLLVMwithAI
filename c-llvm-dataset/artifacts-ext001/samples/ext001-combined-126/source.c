_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc * y) - ((16u << 28u) | (y & x))));
        acc = (acc ^ (7u ^ ((acc << 27u) - (i | i))));
        acc = (acc ^ (((2570378893u - x) - (x & acc)) & 7u));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (((3144186377u >> 31u) * acc) - (2u - (i - y))));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ 0u);
    } else {
        acc = (acc ^ (x >> 2u));
        acc = (acc ^ (31u - acc));
    }
    return acc;
}
