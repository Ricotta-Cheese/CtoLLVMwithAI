_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((16u ^ 0u) & (0u - x)) >> 21u));
        acc = (acc ^ (577663998u - y));
        if (((((x ^ y) ^ i) & 8192u) == 0u)) {
            acc = (acc ^ (i ^ i));
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((y & acc) ^ (x | x)));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
