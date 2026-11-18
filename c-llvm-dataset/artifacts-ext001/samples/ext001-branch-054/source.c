_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (acc >> 10u));
        acc = (acc ^ (y << 27u));
    } else {
        acc = (acc ^ 0u);
    }
    acc = (acc ^ y);
    return acc;
}
