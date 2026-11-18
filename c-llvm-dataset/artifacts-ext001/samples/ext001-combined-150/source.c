_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x ^ i));
        acc = (acc ^ y);
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (x + ((7u & 4294967295u) - (15u ^ x))));
            acc = (acc ^ x);
        } else {
            acc = (acc ^ ((y << 10u) ^ x));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ ((acc << 8u) + (y & acc)));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ ((3u ^ x) + (1u | y)));
        acc = (acc ^ (x ^ 3056448979u));
    }
    return acc;
}
