_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 1u);
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (i >> 26u));
            acc = (acc ^ ((i | i) >> 13u));
        } else {
            acc = (acc ^ ((acc & 15u) & (acc >> 4u)));
            acc = (acc ^ ((x & y) * (7u * acc)));
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (((0u | acc) << 0u) ^ ((acc & 2u) & (261552834u + acc))));
        acc = (acc ^ (7u * x));
    } else {
        acc = (acc ^ (y ^ x));
    }
    return acc;
}
