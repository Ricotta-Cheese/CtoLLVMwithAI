_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((x | y) ^ (acc ^ 31u)) >> 23u));
    acc = (acc ^ (((31u | 0u) >> 3u) ^ ((acc & acc) ^ (0x2u ^ 16u))));
    acc = (acc ^ x);
    acc = (acc ^ y);
    return acc;
}
