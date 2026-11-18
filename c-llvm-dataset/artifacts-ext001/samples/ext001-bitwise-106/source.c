_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((1u >> 9u) | (acc ^ acc)) & acc));
    acc = (acc ^ ((x & acc) >> 19u));
    acc = (acc ^ ((x >> 20u) << 9u));
    return acc;
}
