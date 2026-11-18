_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ y);
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (((i * y) & (y ^ 1u)) * ((acc << 21u) & (x - i))));
        } else {
            acc = (acc ^ (i * x));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((acc * x) - (y - 2u)));
        acc = (acc ^ (acc ^ y));
    } else {
        acc = (acc ^ ((4294967295u << 14u) & (4294967295u + acc)));
        acc = (acc ^ (x >> 6u));
    }
    return acc;
}
