_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ ((x + acc) & (acc + acc)));
    } else {
        acc = (acc ^ ((y - 3u) - (x >> 5u)));
        acc = (acc ^ ((acc >> 11u) & ((y ^ x) * (16u ^ 3u))));
    }
    acc = (acc ^ (acc * x));
    return acc;
}
