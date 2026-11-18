_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((15u ^ x) >> 11u) & ((x & y) ^ x)));
    acc = (acc ^ (1838716530u << 4u));
    acc = (acc ^ ((y >> 1u) >> 30u));
    return acc;
}
