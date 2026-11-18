_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((x << 27u) & (acc + y)));
        acc = (acc ^ (x + 16u));
    } else {
        acc = (acc ^ 3u);
        acc = (acc ^ (((acc | 3u) * (y >> 14u)) << 9u));
    }
    acc = (acc ^ (7u + acc));
    return acc;
}
