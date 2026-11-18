_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (((acc * x) | (1059988244u ^ acc)) & ((y & acc) << 9u)));
    } else {
        acc = (acc ^ (acc ^ acc));
        acc = (acc ^ acc);
    }
    acc = (acc ^ ((1u - y) * (acc << 28u)));
    return acc;
}
