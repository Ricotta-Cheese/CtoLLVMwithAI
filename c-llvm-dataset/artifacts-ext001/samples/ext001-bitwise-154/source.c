_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ ((31u ^ (y >> 19u)) | ((acc << 2u) << 26u)));
    acc = (acc ^ 7u);
    acc = (acc ^ ((y >> 27u) | ((y >> 25u) ^ (x & acc))));
    return acc;
}
