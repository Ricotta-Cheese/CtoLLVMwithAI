_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (x & acc));
    } else {
        acc = (acc ^ (((acc + 3u) >> 18u) + (acc * (31u << 9u))));
    }
    acc = (acc ^ (((acc << 26u) * (2u + acc)) << 16u));
    return acc;
}
