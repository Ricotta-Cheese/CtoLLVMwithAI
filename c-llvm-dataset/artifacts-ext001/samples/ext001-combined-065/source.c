_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y * 15u) + (y << 29u)) << 29u));
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ (y ^ x));
            acc = (acc ^ ((2u + 0u) >> 1u));
        } else {
            acc = (acc ^ ((i << 14u) & (y - 3u)));
        }
    }
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (x >> 4u));
        acc = (acc ^ ((x | 0u) - 16u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (acc | acc));
    }
    return acc;
}
