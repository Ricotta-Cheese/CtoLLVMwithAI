_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (7u >> 26u));
    } else {
        acc = (acc ^ (((y + y) >> 4u) << 2u));
    }
    acc = (acc ^ x);
    return acc;
}
