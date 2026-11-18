_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (((15u | y) ^ (31u + acc)) >> 4u));
        acc = (acc ^ (((2982764050u | x) * 4294967295u) + ((acc ^ acc) ^ (y & y))));
    } else {
        acc = (acc ^ (y | y));
        acc = (acc ^ ((y >> 24u) & ((x << 6u) & (7u | y))));
    }
    acc = (acc ^ ((16u + y) >> 27u));
    return acc;
}
