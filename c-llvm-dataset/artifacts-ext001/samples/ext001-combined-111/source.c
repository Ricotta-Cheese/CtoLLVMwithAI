_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i + 1u) - (y + x)));
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ ((i >> 24u) | (1u * x)));
        } else {
            acc = (acc ^ (1460016066u + 2u));
            acc = (acc ^ ((acc << 23u) << 24u));
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (7u - acc));
        acc = (acc ^ ((1u << 11u) | ((y - y) * (x & x))));
    } else {
        acc = (acc ^ ((y | y) - (acc & 7u)));
    }
    return acc;
}
