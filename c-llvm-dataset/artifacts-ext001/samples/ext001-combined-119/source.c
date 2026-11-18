_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (0u << 18u));
        acc = (acc ^ ((16u ^ 31u) ^ (2u << 28u)));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (acc | (x >> 30u)));
        } else {
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (acc - acc));
        acc = (acc ^ (y | 31u));
    } else {
        acc = (acc ^ 7u);
    }
    return acc;
}
