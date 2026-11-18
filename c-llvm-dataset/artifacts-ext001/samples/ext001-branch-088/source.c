_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((y >> 19u) << 8u));
    } else {
        acc = (acc ^ (x & 16u));
        acc = (acc ^ ((x >> 14u) ^ (2u + acc)));
    }
    acc = (acc ^ ((4294967295u * x) * (y << 1u)));
    return acc;
}
