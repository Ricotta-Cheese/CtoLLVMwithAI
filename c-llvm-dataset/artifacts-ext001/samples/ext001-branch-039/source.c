_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((654362624u >> 20u) * (15u & x)));
    } else {
        acc = (acc ^ (7u ^ y));
        acc = (acc ^ ((2u + x) ^ (x | y)));
    }
    acc = (acc ^ ((31u + acc) | 3276907284u));
    return acc;
}
