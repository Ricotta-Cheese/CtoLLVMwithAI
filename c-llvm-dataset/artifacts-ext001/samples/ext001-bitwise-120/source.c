_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (acc >> 17u));
    acc = (acc ^ ((acc ^ 4294967295u) ^ (acc >> 25u)));
    return acc;
}
