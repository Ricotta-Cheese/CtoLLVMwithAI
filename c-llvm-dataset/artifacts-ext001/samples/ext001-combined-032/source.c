_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i >> 15u) * (y + i)));
        acc = (acc ^ (acc ^ y));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (2u << 8u));
            acc = (acc ^ (((7u + 15u) << 12u) << 31u));
        }
    }
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (((y | acc) >> 8u) + (y - (acc >> 26u))));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
