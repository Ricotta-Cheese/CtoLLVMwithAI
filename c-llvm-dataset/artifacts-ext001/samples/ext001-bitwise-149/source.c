_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((acc >> 28u) >> 0u));
    acc = (acc ^ (903784095u ^ y));
    acc = (acc ^ (31u ^ (acc ^ x)));
    return acc;
}
