_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ y);
        acc = (acc ^ ((acc << 5u) + (x ^ acc)));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ 7u);
            acc = (acc ^ ((acc + 15u) << 0u));
        } else {
            acc = (acc ^ (x >> 13u));
            acc = (acc ^ ((7u | 15u) << 17u));
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (y << 4u));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
