_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (((y | y) | (y & x)) ^ (16u + acc)));
        acc = (acc ^ ((x - (2u + acc)) + (acc - 3u)));
    } else {
        acc = (acc ^ (acc ^ acc));
        acc = (acc ^ 16u);
    }
    acc = (acc ^ (((15u + acc) - 4294967295u) + ((y ^ acc) >> 16u)));
    return acc;
}
