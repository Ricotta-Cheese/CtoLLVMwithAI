_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((y & 3u) * y));
        acc = (acc ^ ((1u | acc) ^ (1u << 3u)));
    } else {
        acc = (acc ^ ((y & y) & (acc - acc)));
        acc = (acc ^ (((y >> 29u) & 2u) + ((0u | acc) * (y * x))));
    }
    acc = (acc ^ x);
    return acc;
}
