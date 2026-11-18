_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((x ^ 0u) << 6u) ^ ((x >> 19u) << 1u)));
    acc = (acc ^ x);
    return acc;
}
