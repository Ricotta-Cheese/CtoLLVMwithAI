_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((y + x) >> 19u));
    } else {
        acc = (acc ^ ((y + y) - (31u << 7u)));
        acc = (acc ^ (y & ((x & acc) + (x >> 1u))));
    }
    acc = (acc ^ 16u);
    return acc;
}
