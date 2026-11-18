_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y | y) * (y & x)) ^ ((16u + acc) - (4294967295u * i))));
        acc = (acc ^ (i << 14u));
        acc = (acc ^ (31u - ((x ^ 2040414054u) >> 22u)));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (y | y));
            acc = (acc ^ (y >> 1u));
        } else {
            acc = (acc ^ (y & 15u));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (x | y));
    } else {
        acc = (acc ^ ((x & (x >> 24u)) >> 17u));
    }
    return acc;
}
