_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (acc - x));
        acc = (acc ^ (((x + x) << 21u) - ((acc + acc) * (x + 1u))));
    } else {
        acc = (acc ^ 31u);
        acc = (acc ^ (x * y));
    }
    acc = (acc ^ (((y ^ y) >> 26u) ^ (x >> 17u)));
    return acc;
}
