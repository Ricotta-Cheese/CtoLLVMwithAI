_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ ((7u - y) << 2u));
    } else {
        acc = (acc ^ (acc & acc));
        acc = (acc ^ ((x & 2u) - ((acc + acc) + (31u >> 27u))));
    }
    acc = (acc ^ (((acc - x) * (16u ^ x)) - ((15u ^ x) + acc)));
    return acc;
}
