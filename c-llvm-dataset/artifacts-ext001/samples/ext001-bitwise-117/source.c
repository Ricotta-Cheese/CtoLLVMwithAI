_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (x & acc));
    acc = (acc ^ (((acc ^ y) >> 18u) >> 6u));
    acc = (acc ^ ((acc << 28u) | ((15u | 1u) | (4294967295u >> 25u))));
    return acc;
}
