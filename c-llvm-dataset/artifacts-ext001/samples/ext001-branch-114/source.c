_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (15u >> 8u));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((acc >> 17u) & (acc - y)));
    }
    acc = (acc ^ (((y ^ x) - (acc << 15u)) ^ ((x ^ acc) >> 6u)));
    return acc;
}
