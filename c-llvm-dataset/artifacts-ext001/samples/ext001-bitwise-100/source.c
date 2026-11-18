_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (1u << 10u));
    acc = (acc ^ y);
    acc = (acc ^ (((3u | x) ^ acc) >> 22u));
    acc = (acc ^ ((x | y) ^ (7u << 30u)));
    return acc;
}
