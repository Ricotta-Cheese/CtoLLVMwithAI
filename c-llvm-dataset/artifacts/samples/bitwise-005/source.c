_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((acc << 7u) >> 24u));
    acc = (acc ^ acc);
    acc = (acc ^ (1u ^ ((y & acc) ^ y)));
    acc = (acc ^ (((acc >> 1u) | (acc | acc)) << 28u));
    return acc;
}
