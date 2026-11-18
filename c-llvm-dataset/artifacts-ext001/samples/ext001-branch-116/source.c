_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((1u & x) >> 24u));
        acc = (acc ^ (x ^ acc));
    } else {
        acc = (acc ^ x);
    }
    acc = (acc ^ ((4294967295u << 11u) >> 5u));
    return acc;
}
