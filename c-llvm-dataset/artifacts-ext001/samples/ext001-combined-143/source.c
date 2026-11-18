_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((15u * acc) * (acc ^ 4294967295u)));
        acc = (acc ^ (((acc << 8u) << 5u) | (i - (acc & x))));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ 31u);
            acc = (acc ^ (((acc ^ acc) ^ (i << 25u)) - ((y + x) + (0u | i))));
        } else {
            acc = (acc ^ ((acc - acc) ^ (i - 7u)));
            acc = (acc ^ (acc - 4294967295u));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ 31u);
        acc = (acc ^ (y & x));
    } else {
        acc = (acc ^ 15u);
    }
    return acc;
}
