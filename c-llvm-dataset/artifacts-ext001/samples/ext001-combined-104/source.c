_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y - acc) ^ (x & acc)));
        acc = (acc ^ (y ^ x));
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ (i * ((x ^ y) >> 2u)));
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (y * x));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (31u & 7u));
    } else {
        acc = (acc ^ (x & x));
        acc = (acc ^ ((acc >> 20u) * (7u ^ x)));
    }
    return acc;
}
