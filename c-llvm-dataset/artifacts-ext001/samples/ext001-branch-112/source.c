_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (2u & x));
        acc = (acc ^ ((y + acc) | (acc ^ y)));
    } else {
        acc = (acc ^ (acc << 18u));
    }
    acc = (acc ^ (((x ^ y) >> 0u) + (3u + (x & x))));
    return acc;
}
