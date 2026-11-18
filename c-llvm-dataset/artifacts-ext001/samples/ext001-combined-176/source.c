_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc - 31u) - i));
        acc = (acc ^ 0u);
        acc = (acc ^ (acc & y));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ i);
            acc = (acc ^ ((y + i) >> 3u));
        } else {
            acc = (acc ^ (x << 31u));
            acc = (acc ^ 16u);
        }
    }
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ ((acc << 9u) - (acc ^ 15u)));
        acc = (acc ^ (y & ((y >> 18u) << 10u)));
    } else {
        acc = (acc ^ (y ^ y));
    }
    return acc;
}
