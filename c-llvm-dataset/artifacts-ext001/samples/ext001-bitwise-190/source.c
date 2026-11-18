_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((4294967295u | x) ^ (acc & acc)) & ((x << 27u) | (x & x))));
    acc = (acc ^ (acc >> 6u));
    acc = (acc ^ (x >> 27u));
    return acc;
}
