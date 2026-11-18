_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (7u >> 3u));
        acc = (acc ^ 1u);
    } else {
        acc = (acc ^ (x | y));
        acc = (acc ^ (acc ^ x));
    }
    acc = (acc ^ x);
    return acc;
}
