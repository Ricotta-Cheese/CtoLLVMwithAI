_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ ((3u - x) + (x | x)));
    } else {
        acc = (acc ^ (16u & y));
        acc = (acc ^ (acc >> 6u));
    }
    acc = (acc ^ ((1u >> 14u) - ((x * 2u) & (x - 7u))));
    return acc;
}
