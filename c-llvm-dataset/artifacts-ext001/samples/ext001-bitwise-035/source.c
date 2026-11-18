_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (15u & acc));
    acc = (acc ^ ((acc >> 18u) & 3u));
    acc = (acc ^ y);
    acc = (acc ^ (y ^ (x | acc)));
    return acc;
}
