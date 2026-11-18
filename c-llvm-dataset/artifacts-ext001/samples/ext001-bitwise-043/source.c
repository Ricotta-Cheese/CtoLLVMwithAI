_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((1u ^ y) >> 21u) << 7u));
    acc = (acc ^ (x | acc));
    acc = (acc ^ (acc >> 3u));
    return acc;
}
