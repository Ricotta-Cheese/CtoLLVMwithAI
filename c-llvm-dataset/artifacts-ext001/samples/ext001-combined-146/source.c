_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y ^ i) >> 30u));
        acc = (acc ^ (y << 23u));
        acc = (acc ^ (((1u + acc) >> 13u) * ((x - y) ^ (y - 31u))));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ ((acc | y) >> 3u));
        } else {
            acc = (acc ^ (((acc ^ x) * (x + x)) * ((y + i) >> 10u)));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((acc | 2u) | (16u ^ y)));
    }
    return acc;
}
