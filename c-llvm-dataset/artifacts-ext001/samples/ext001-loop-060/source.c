_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x ^ acc));
        acc = (acc ^ ((acc >> 1u) | (acc + x)));
        acc = (acc ^ ((x | (4255942771u - acc)) & (3u | (x >> 22u))));
    }
    return acc;
}
