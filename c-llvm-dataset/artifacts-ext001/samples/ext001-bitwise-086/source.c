_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (acc & x));
    acc = (acc ^ y);
    acc = (acc ^ (4294967295u >> 22u));
    acc = (acc ^ (((acc | 15u) >> 25u) ^ ((x >> 19u) & (x << 12u))));
    return acc;
}
