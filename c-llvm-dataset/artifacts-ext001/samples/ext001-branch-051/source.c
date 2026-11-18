_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (y ^ ((3u << 11u) * (y * y))));
    } else {
        acc = (acc ^ (31u - x));
        acc = (acc ^ (((y - x) >> 30u) << 17u));
    }
    acc = (acc ^ ((7u << 5u) ^ (y * x)));
    return acc;
}
