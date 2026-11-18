_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((acc + 3u) ^ y));
        acc = (acc ^ (y << 18u));
    } else {
        acc = (acc ^ (acc + 4077614559u));
    }
    acc = (acc ^ (16u >> 17u));
    return acc;
}
