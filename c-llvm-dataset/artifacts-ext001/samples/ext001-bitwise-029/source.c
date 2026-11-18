_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((acc ^ 1u) ^ (acc | y)) & ((0u | 3140235509u) | acc)));
    acc = (acc ^ (x | acc));
    acc = (acc ^ ((15u << 8u) >> 12u));
    acc = (acc ^ (((x & acc) >> 31u) ^ ((7u >> 18u) >> 3u)));
    return acc;
}
