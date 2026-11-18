_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (x & ((7u << 30u) ^ (y << 1u))));
    acc = (acc ^ (y >> 30u));
    acc = (acc ^ (((x ^ acc) | (acc & x)) << 21u));
    return acc;
}
