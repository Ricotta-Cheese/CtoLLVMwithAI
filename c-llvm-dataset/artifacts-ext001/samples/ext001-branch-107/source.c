_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (x - acc));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (7u >> 26u));
    return acc;
}
