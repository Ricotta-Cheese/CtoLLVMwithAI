_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((0u & acc) >> 23u) - ((acc << 24u) >> 23u)));
        acc = (acc ^ ((y ^ x) * (15u << 20u)));
        if (((((x ^ y) ^ i) & 262144u) == 0u)) {
            acc = (acc ^ (acc * i));
        } else {
            acc = (acc ^ (2u << 15u));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (acc & 7u));
    } else {
        acc = (acc ^ (((x + x) * (acc & y)) & ((y * x) | (x - x))));
    }
    return acc;
}
