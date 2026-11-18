_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc ^ x) & (i | y)));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ (x ^ (y << 8u)));
            acc = (acc ^ (31u - i));
        } else {
            acc = (acc ^ y);
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ (acc + y));
        acc = (acc ^ ((7u & x) ^ (acc - acc)));
    } else {
        acc = (acc ^ (1u >> 16u));
        acc = (acc ^ ((acc & x) - (0u + acc)));
    }
    return acc;
}
