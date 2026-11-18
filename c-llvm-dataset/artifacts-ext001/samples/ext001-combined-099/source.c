_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc + 16u) ^ x) ^ ((i >> 28u) << 18u)));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ ((x & 2u) + 31u));
        } else {
            acc = (acc ^ ((i & x) >> 6u));
            acc = (acc ^ (((1163892998u << 21u) + (acc - acc)) ^ ((x - 16u) * (4294967295u | y))));
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (acc - acc));
    }
    return acc;
}
