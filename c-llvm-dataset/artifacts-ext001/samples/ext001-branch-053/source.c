_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ ((y & y) >> 24u));
    } else {
        acc = (acc ^ (acc | y));
    }
    acc = (acc ^ ((y ^ 15u) | (16u * x)));
    return acc;
}
