_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((3u & acc) & x));
    acc = (acc ^ (((x << 15u) >> 12u) & acc));
    acc = (acc ^ (y >> 16u));
    acc = (acc ^ 0u);
    return acc;
}
