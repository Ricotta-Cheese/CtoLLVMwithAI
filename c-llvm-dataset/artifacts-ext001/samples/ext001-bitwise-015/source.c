_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((y >> 19u) & (x & 31u)));
    acc = (acc ^ (1u | acc));
    acc = (acc ^ (acc >> 3u));
    acc = (acc ^ ((y ^ x) & (x >> 11u)));
    return acc;
}
