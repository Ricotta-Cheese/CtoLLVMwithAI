_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (x << 26u));
        acc = (acc ^ ((y ^ 1u) * 2085506816u));
    } else {
        acc = (acc ^ 0u);
    }
    acc = (acc ^ ((x + acc) << 28u));
    return acc;
}
