_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((acc + y) - x));
    } else {
        acc = (acc ^ (0u >> 28u));
    }
    acc = (acc ^ (((acc - 2881014370u) - (3u << 15u)) + ((acc ^ 3u) << 12u)));
    return acc;
}
