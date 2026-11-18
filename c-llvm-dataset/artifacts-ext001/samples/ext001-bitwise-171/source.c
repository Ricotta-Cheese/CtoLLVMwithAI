_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((0u << 22u) ^ ((y & y) ^ (acc >> 21u))));
    acc = (acc ^ (((x & x) >> 3u) | (acc ^ (acc & acc))));
    return acc;
}
