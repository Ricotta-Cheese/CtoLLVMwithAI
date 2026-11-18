_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i >> 26u));
        acc = (acc ^ ((x ^ x) - (15u + i)));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ x);
        } else {
            acc = (acc ^ (((y & i) >> 12u) >> 24u));
            acc = (acc ^ (x + x));
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (acc & 16u));
        acc = (acc ^ ((x | 2u) | (y ^ y)));
    } else {
        acc = (acc ^ 31u);
    }
    return acc;
}
