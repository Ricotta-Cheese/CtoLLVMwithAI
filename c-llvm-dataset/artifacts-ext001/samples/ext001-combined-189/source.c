_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i >> 14u) ^ (i & x)));
        acc = (acc ^ ((i << 1u) | x));
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ ((y << 13u) ^ (x << 16u)));
        } else {
            acc = (acc ^ ((y - (acc & acc)) & ((0u + acc) + i)));
            acc = (acc ^ (0u & ((acc & acc) << 31u)));
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (0u >> 4u));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ ((x & acc) >> 30u));
        acc = (acc ^ (y << 31u));
    }
    return acc;
}
