_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ (x >> 23u));
    } else {
        acc = (acc ^ (y ^ ((acc | y) & (y >> 31u))));
    }
    acc = (acc ^ (4294967295u << 7u));
    return acc;
}
