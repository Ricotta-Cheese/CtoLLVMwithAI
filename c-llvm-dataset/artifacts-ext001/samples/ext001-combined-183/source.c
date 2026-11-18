_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc >> 31u));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ ((4294967295u ^ (x & acc)) + x));
            acc = (acc ^ (x - acc));
        } else {
            acc = (acc ^ (((2u * y) & (acc >> 11u)) & ((acc << 30u) << 0u)));
            acc = (acc ^ (437041533u | acc));
        }
    }
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (((acc + y) * x) >> 26u));
        acc = (acc ^ (y >> 0u));
    } else {
        acc = (acc ^ (x + acc));
    }
    return acc;
}
