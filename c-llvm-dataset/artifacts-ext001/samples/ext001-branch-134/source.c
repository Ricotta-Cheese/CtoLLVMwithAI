_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (x - x));
        acc = (acc ^ ((7u << 25u) & (16u >> 17u)));
    }
    acc = (acc ^ ((x + 4294967295u) >> 11u));
    return acc;
}
