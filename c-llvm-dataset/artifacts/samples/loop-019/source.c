_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i << 6u) & (i & acc)) & ((y * y) ^ (31u >> 25u))));
        acc = (acc ^ (0u << 27u));
        acc = (acc ^ (i + acc));
    }
    return acc;
}
