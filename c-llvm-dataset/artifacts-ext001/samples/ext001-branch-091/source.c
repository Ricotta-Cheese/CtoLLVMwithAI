_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (1u - ((7u >> 10u) + (y - x))));
        acc = (acc ^ ((acc * 4182447200u) | (x << 10u)));
    }
    acc = (acc ^ ((31u << 4u) - (acc * x)));
    return acc;
}
