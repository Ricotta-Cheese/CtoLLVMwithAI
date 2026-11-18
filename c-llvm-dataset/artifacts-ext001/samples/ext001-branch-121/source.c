_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (y >> 5u));
    } else {
        acc = (acc ^ (((x >> 6u) << 28u) | ((acc & x) >> 23u)));
    }
    acc = (acc ^ x);
    return acc;
}
