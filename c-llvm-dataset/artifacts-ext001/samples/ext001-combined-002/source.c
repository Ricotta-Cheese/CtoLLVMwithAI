_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y | y));
        acc = (acc ^ ((2u & x) ^ (7u * 4294967295u)));
        if (((((x ^ y) ^ i) & 8u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (((x | 3u) | acc) & x));
            acc = (acc ^ ((x << 23u) + (x & i)));
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (acc << 14u));
    } else {
        acc = (acc ^ (acc + 2161700969u));
        acc = (acc ^ x);
    }
    return acc;
}
