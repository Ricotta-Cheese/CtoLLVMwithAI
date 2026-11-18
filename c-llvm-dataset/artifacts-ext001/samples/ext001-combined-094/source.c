_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc << 20u) & (4294967295u >> 3u)));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ ((y << 0u) | y));
        } else {
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (x ^ acc));
    } else {
        acc = (acc ^ ((x * y) * (x * 3u)));
    }
    return acc;
}
