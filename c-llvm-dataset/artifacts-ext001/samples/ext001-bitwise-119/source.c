_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ ((acc >> 4u) >> 31u));
    acc = (acc ^ (((acc >> 9u) | (acc ^ x)) | ((x & acc) | (x | 0u))));
    acc = (acc ^ y);
    return acc;
}
