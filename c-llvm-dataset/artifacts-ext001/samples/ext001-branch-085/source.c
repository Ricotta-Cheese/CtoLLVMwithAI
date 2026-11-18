_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ (x * (x & 7u)));
    } else {
        acc = (acc ^ (((acc >> 31u) * (y ^ x)) - (acc << 28u)));
    }
    acc = (acc ^ 172825329u);
    return acc;
}
