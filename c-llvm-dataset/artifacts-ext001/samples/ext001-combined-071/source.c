_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y + i));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (y | (y | acc)));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (acc | y));
        acc = (acc ^ ((16u & 0u) - (2u << 21u)));
    }
    return acc;
}
