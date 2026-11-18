_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (y >> 3u));
    acc = (acc ^ y);
    acc = (acc ^ (((31u << 31u) | (y & y)) >> 22u));
    acc = (acc ^ x);
    return acc;
}
