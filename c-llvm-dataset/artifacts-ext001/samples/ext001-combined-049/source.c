_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i >> 5u) << 11u));
        acc = (acc ^ (acc * y));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ ((y * acc) - (x + x)));
        } else {
            acc = (acc ^ ((7u ^ x) + (2u - 15u)));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (((y - 15u) - (16u + 15u)) << 15u));
        acc = (acc ^ (7u + 3u));
    } else {
        acc = (acc ^ (15u * 15u));
    }
    return acc;
}
