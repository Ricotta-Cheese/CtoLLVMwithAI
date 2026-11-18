_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ (((31u & x) + (16u ^ 7u)) >> 10u));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (y * (y - (x - x))));
    }
    acc = (acc ^ y);
    return acc;
}
