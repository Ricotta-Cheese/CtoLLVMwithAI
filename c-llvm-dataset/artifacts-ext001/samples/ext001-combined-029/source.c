_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (31u >> 24u));
        acc = (acc ^ ((16u * i) | (i >> 28u)));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ (((x >> 25u) >> 26u) << 22u));
            acc = (acc ^ (((acc >> 9u) << 1u) - i));
        } else {
            acc = (acc ^ ((15u | 2u) * (x | i)));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ (x >> 26u));
    } else {
        acc = (acc ^ y);
    }
    return acc;
}
