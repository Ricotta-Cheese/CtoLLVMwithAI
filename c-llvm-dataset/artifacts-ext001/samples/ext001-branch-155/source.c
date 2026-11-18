_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ ((1u + (y & x)) - ((y + y) << 2u)));
    } else {
        acc = (acc ^ ((acc * 0u) * (acc | x)));
    }
    acc = (acc ^ y);
    return acc;
}
