_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y >> 22u) + (acc * 7u)));
        acc = (acc ^ (y + x));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (i >> 13u));
            acc = (acc ^ (i + ((3095876219u & i) >> 0u)));
        } else {
            acc = (acc ^ ((x >> 31u) & (y & i)));
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (y - x));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
