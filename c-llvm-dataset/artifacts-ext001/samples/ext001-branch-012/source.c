_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ (acc & x));
    } else {
        acc = (acc ^ ((x >> 29u) | (0u | acc)));
        acc = (acc ^ (y & (x | (16u + acc))));
    }
    acc = (acc ^ ((y << 7u) - (y | acc)));
    return acc;
}
