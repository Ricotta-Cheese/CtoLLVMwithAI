_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i ^ i) >> 2u) | (i ^ (i >> 4u))));
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (2290607569u & 16u));
        } else {
            acc = (acc ^ ((y | acc) | (acc - x)));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ x);
    } else {
        acc = (acc ^ (3060091290u ^ y));
        acc = (acc ^ x);
    }
    return acc;
}
