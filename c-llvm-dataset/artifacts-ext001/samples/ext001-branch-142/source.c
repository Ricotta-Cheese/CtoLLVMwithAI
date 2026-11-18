_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (y ^ ((acc | 31u) - (x & x))));
    } else {
        acc = (acc ^ (acc << 27u));
    }
    acc = (acc ^ (y + 3u));
    return acc;
}
