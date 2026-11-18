_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 944078527u);
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (x ^ ((i * 15u) - (3u + 0u))));
            acc = (acc ^ ((i + 3u) ^ (i >> 8u)));
        } else {
            acc = (acc ^ (16u ^ i));
            acc = (acc ^ (x | y));
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ ((y + (x ^ x)) & ((x | acc) + (acc + 31u))));
    } else {
        acc = (acc ^ (((y - acc) + (x & y)) & (y ^ (0u & acc))));
    }
    return acc;
}
