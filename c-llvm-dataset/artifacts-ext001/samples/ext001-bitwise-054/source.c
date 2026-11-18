_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((x | 2u) >> 13u));
    acc = (acc ^ (2u & acc));
    acc = (acc ^ (acc & (2940866478u >> 19u)));
    acc = (acc ^ ((7u << 15u) ^ (x >> 10u)));
    return acc;
}
