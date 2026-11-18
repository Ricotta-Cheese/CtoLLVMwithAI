_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 2048u) == 0u)) {
            acc = (acc ^ (15u >> 8u));
            acc = (acc ^ (y | (acc & 1u)));
        } else {
            acc = (acc ^ (acc ^ 1u));
            acc = (acc ^ (acc << 27u));
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (((y | acc) + (y << 19u)) >> 8u));
    } else {
        acc = (acc ^ (y | (x << 23u)));
        acc = (acc ^ (y - ((acc * x) - y)));
    }
    return acc;
}
