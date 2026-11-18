_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (y & 2u));
    } else {
        acc = (acc ^ x);
    }
    acc = (acc ^ (x ^ 7u));
    return acc;
}
