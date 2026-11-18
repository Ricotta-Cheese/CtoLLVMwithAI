_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc + 147199716u) ^ (x - y)) + ((x & acc) + (15u >> 3u))));
        acc = (acc ^ (((acc | i) * (x << 24u)) << 0u));
    }
    return acc;
}
