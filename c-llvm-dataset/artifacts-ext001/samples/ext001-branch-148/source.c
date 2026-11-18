_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ ((3u & (y | y)) * 3u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ x);
    }
    acc = (acc ^ (((31u >> 19u) >> 18u) & ((x << 26u) ^ (3u + 7u))));
    return acc;
}
