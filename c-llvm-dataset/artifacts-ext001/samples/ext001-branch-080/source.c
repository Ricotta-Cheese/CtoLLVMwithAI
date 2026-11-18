_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (((acc ^ 1u) << 5u) >> 16u));
        acc = (acc ^ ((0u * 4294967295u) >> 25u));
    } else {
        acc = (acc ^ ((x - y) << 6u));
    }
    acc = (acc ^ (acc * 2u));
    return acc;
}
