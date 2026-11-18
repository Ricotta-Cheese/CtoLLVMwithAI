_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (31u ^ x));
    acc = (acc ^ ((acc >> 23u) | (15u ^ acc)));
    acc = (acc ^ ((x >> 6u) >> 17u));
    acc = (acc ^ (4209555276u | y));
    return acc;
}
