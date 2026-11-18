_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ (31u * y));
        acc = (acc ^ ((acc ^ 2u) - (y + x)));
    } else {
        acc = (acc ^ (y << 20u));
    }
    acc = (acc ^ (31u | 2u));
    return acc;
}
