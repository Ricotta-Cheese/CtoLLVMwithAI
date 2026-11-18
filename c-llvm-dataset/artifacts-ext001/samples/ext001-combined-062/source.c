_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((4294967295u + y) - (acc & i)));
        acc = (acc ^ (((y >> 19u) - (i - y)) ^ (1u & (y + y))));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ ((acc << 16u) * (x << 24u)));
            acc = (acc ^ (acc | x));
        }
    }
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (x >> 28u));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
