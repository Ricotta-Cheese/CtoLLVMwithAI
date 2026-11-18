_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ ((7u - 7u) - (16u * x)));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (((acc << 30u) & 3u) >> 14u));
        acc = (acc ^ (acc - (acc << 10u)));
    }
    acc = (acc ^ (0u >> 18u));
    return acc;
}
