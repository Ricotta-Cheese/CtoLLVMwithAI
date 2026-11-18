_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (((y ^ x) * (y << 17u)) << 30u));
        acc = (acc ^ (acc * 1u));
    } else {
        acc = (acc ^ (acc | ((y - 284824282u) + (2u | y))));
    }
    acc = (acc ^ y);
    return acc;
}
