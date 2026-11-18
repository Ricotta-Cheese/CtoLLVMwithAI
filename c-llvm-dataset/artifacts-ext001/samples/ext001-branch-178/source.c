_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (x * acc));
        acc = (acc ^ (y * 1u));
    } else {
        acc = (acc ^ (x >> 30u));
    }
    acc = (acc ^ (((x >> 2u) | y) << 3u));
    return acc;
}
