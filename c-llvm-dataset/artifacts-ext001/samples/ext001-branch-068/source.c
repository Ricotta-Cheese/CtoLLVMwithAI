_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ ((x >> 0u) & (y | acc)));
    } else {
        acc = (acc ^ ((y ^ acc) ^ (x | x)));
        acc = (acc ^ 3u);
    }
    acc = (acc ^ (x + y));
    return acc;
}
