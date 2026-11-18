_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (((acc | x) >> 12u) & (y - (y & acc))));
    } else {
        acc = (acc ^ 0u);
        acc = (acc ^ (((0u >> 8u) - 31u) * ((4294967295u << 15u) >> 9u)));
    }
    acc = (acc ^ ((acc ^ 7u) >> 18u));
    return acc;
}
