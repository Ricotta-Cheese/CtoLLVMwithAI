_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((31u * y) | (y + y)));
    }
    acc = (acc ^ (y - 0u));
    return acc;
}
