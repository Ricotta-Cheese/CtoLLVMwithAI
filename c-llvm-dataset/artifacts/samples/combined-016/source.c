_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i | i) >> 10u));
        if (((((x ^ y) ^ i) & 8u) == 0u)) {
            acc = (acc ^ acc);
            acc = (acc ^ (((16u | y) | acc) ^ (15u >> 24u)));
        } else {
            acc = (acc ^ (i & x));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ (acc & acc));
        acc = (acc ^ (((acc + x) | (y >> 30u)) >> 15u));
    } else {
        acc = (acc ^ (y - acc));
        acc = (acc ^ y);
    }
    return acc;
}
