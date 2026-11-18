_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ ((1u - 16u) * (acc | 1u)));
    } else {
        acc = (acc ^ y);
    }
    acc = (acc ^ (y ^ 16u));
    return acc;
}
