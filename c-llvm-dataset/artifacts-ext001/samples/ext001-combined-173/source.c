_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        acc = (acc ^ ((acc & x) | y));
        if (((((x ^ y) ^ i) & 16384u) == 0u)) {
            acc = (acc ^ (0u >> 4u));
        } else {
            acc = (acc ^ ((i | acc) - (y * x)));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (y << 12u));
    }
    return acc;
}
