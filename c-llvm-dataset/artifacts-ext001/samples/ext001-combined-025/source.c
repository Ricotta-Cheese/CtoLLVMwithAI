_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x << 13u) | (3u | y)));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ (1u - 0u));
            acc = (acc ^ 2u);
        } else {
            acc = (acc ^ ((y - (x << 14u)) * ((acc + i) - (acc - y))));
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (acc ^ (acc << 11u)));
    } else {
        acc = (acc ^ (((acc + y) - (x & acc)) << 15u));
        acc = (acc ^ acc);
    }
    return acc;
}
