_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((y >> 21u) & (y & x)) << 16u));
    acc = (acc ^ (2u | acc));
    acc = (acc ^ (y & 3u));
    return acc;
}
