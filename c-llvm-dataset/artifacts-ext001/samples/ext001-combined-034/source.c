_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x * x));
        acc = (acc ^ acc);
        acc = (acc ^ (0u | i));
        if (((((x ^ y) ^ i) & 2097152u) == 0u)) {
            acc = (acc ^ ((x ^ i) >> 12u));
        } else {
            acc = (acc ^ (i & 31u));
            acc = (acc ^ (3264871224u - x));
        }
    }
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ ((x * 16u) | (x >> 24u)));
        acc = (acc ^ (acc & x));
    } else {
        acc = (acc ^ (((y >> 7u) | x) >> 19u));
    }
    return acc;
}
