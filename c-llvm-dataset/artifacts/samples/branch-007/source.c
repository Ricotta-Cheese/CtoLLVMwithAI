_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (x * (0u >> 20u)));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (acc | ((y + 15u) << 10u)));
    return acc;
}
