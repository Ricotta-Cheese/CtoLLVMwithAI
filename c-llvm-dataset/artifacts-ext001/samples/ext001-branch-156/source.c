_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((y ^ 4294967295u) + (x + y)));
    } else {
        acc = (acc ^ (y & 7u));
    }
    acc = (acc ^ (((y + y) >> 25u) ^ (acc ^ y)));
    return acc;
}
