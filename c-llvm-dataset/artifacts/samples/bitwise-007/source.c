_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((acc ^ x) | (3682684371u >> 24u)) & ((x ^ y) ^ (2u >> 6u))));
    acc = (acc ^ (y >> 27u));
    acc = (acc ^ ((y << 10u) & (x >> 12u)));
    return acc;
}
