_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (x + y));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ 7u);
    }
    acc = (acc ^ (((7u << 12u) >> 11u) ^ ((y * 3u) * (15u | 3185661060u))));
    return acc;
}
