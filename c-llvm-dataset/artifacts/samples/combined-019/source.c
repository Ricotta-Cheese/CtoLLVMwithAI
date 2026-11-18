_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i - i));
        acc = (acc ^ (x & x));
        acc = (acc ^ (acc | x));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ (x >> 1u));
        } else {
            acc = (acc ^ (i & acc));
        }
    }
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (1u >> 24u));
        acc = (acc ^ (acc + y));
    } else {
        acc = (acc ^ (((acc ^ 7u) | (y + x)) ^ ((x & x) ^ y)));
    }
    return acc;
}
