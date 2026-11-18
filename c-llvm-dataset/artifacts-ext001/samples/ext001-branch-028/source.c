_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ ((acc + x) >> 27u));
        acc = (acc ^ (acc ^ (acc + x)));
    } else {
        acc = (acc ^ 0u);
    }
    acc = (acc ^ ((3u >> 13u) | ((0x2u ^ 3u) - acc)));
    return acc;
}
