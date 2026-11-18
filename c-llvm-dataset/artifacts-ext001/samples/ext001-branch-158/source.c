_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (16u ^ acc));
        acc = (acc ^ 168914070u);
    } else {
        acc = (acc ^ (((y & x) | (3u ^ y)) ^ ((x | y) << 7u)));
    }
    acc = (acc ^ 1u);
    return acc;
}
