_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i + i) * 7u) << 17u));
        acc = (acc ^ (((x + acc) | (x >> 1u)) << 19u));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (x | 31u));
        } else {
            acc = (acc ^ (((x | acc) | y) ^ y));
        }
    }
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (y ^ ((2u | 4294967295u) * (y * 2u))));
    }
    return acc;
}
