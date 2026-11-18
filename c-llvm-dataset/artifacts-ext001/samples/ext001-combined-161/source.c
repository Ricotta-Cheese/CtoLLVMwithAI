_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((3u | acc) - (acc - i)) * ((i + i) << 30u)));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ (2u & x));
        } else {
            acc = (acc ^ (31u + acc));
            acc = (acc ^ ((7u | acc) ^ (i * acc)));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((1u - (y + acc)) >> 20u));
    } else {
        acc = (acc ^ (y << 13u));
        acc = (acc ^ (acc + (2u | acc)));
    }
    return acc;
}
