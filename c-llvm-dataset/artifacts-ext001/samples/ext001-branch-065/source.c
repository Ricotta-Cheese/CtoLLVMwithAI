_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ 0u);
    } else {
        acc = (acc ^ ((y * acc) | (x >> 25u)));
    }
    acc = (acc ^ y);
    return acc;
}
