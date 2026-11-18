_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ x);
    acc = (acc ^ (((x >> 16u) ^ (3755854696u >> 9u)) & ((948553311u | acc) ^ (1u ^ x))));
    return acc;
}
