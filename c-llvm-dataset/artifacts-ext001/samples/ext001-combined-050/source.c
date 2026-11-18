_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x & i) & (x & y)));
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ y);
            acc = (acc ^ x);
        } else {
            acc = (acc ^ (((i | acc) & (2u + y)) + (i * i)));
            acc = (acc ^ ((0u * x) & (x & y)));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (7u + 15u));
    } else {
        acc = (acc ^ (acc & acc));
    }
    return acc;
}
