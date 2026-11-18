_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (x >> 10u));
    } else {
        acc = (acc ^ ((y | (x ^ 3u)) & ((x | acc) | (acc | acc))));
        acc = (acc ^ (acc - y));
    }
    acc = (acc ^ (x * x));
    return acc;
}
