_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ acc);
    acc = (acc ^ (y << 22u));
    acc = (acc ^ (((x & x) >> 14u) & acc));
    acc = (acc ^ (2u | (acc & (y >> 17u))));
    return acc;
}
