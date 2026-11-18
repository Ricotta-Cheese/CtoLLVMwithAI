_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((7u ^ 3273494882u) >> 23u) << 4u));
    acc = (acc ^ ((7u | (1u >> 31u)) & acc));
    acc = (acc ^ (y >> 10u));
    acc = (acc ^ (16u & 15u));
    return acc;
}
