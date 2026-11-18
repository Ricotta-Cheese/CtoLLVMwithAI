_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (y ^ x));
        acc = (acc ^ (4294967295u ^ y));
    } else {
        acc = (acc ^ ((x << 16u) * (acc - x)));
    }
    acc = (acc ^ x);
    return acc;
}
