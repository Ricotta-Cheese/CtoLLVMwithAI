_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x | x) | (x + y)) - ((acc * i) >> 17u)));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ (16u << 13u));
        } else {
            acc = (acc ^ ((y | y) ^ (i | y)));
            acc = (acc ^ (((acc & acc) + (x | x)) & ((x - i) >> 31u)));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ 2u);
    } else {
        acc = (acc ^ y);
    }
    return acc;
}
