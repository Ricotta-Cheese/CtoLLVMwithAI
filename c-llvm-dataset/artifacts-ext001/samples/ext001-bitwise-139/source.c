_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (x >> 13u));
    acc = (acc ^ (((acc << 24u) | (16u >> 25u)) << 29u));
    acc = (acc ^ acc);
    acc = (acc ^ ((y ^ 2457539809u) | 7u));
    return acc;
}
