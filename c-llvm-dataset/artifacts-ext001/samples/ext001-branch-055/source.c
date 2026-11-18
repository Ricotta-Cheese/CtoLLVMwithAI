_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (x * y));
        acc = (acc ^ (((x * y) & (acc - 16u)) * (689279952u >> 15u)));
    }
    acc = (acc ^ y);
    return acc;
}
