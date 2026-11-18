_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y >> 24u));
        acc = (acc ^ (i >> 26u));
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ 3u);
        } else {
            acc = (acc ^ ((y | acc) & (0u - i)));
            acc = (acc ^ ((y << 17u) | (2752937899u - x)));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (31u | y));
    } else {
        acc = (acc ^ ((x & acc) & (31u & acc)));
        acc = (acc ^ ((y + (x << 27u)) & ((31u & y) + (x | acc))));
    }
    return acc;
}
