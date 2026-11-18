_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((x >> 25u) | (x ^ y)));
    acc = (acc ^ 16u);
    acc = (acc ^ y);
    acc = (acc ^ ((acc >> 20u) | (x | x)));
    return acc;
}
