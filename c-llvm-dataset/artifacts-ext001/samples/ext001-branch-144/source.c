_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ (1u & (y ^ 1920701867u)));
    } else {
        acc = (acc ^ ((x - (3u >> 30u)) << 28u));
    }
    acc = (acc ^ (2u * 1u));
    return acc;
}
