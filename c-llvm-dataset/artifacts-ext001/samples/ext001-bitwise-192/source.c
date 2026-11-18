_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((acc >> 15u) >> 25u));
    acc = (acc ^ ((3122249532u << 9u) & (7u | y)));
    acc = (acc ^ 16u);
    acc = (acc ^ 3u);
    return acc;
}
