_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((acc >> 25u) << 6u) ^ ((acc ^ y) >> 28u)));
    acc = (acc ^ (x & 1570721736u));
    return acc;
}
