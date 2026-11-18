_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (((7u ^ 15u) & (acc ^ 2u)) ^ ((4294967295u & y) | (y ^ 15u))));
    } else {
        acc = (acc ^ ((x | y) | (acc ^ x)));
    }
    acc = (acc ^ (acc >> 17u));
    return acc;
}
