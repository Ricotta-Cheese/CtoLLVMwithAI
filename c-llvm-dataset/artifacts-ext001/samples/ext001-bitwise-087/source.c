_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((x | 7u) >> 4u) | (x ^ (y << 5u))));
    acc = (acc ^ (((acc & acc) >> 3u) & ((acc >> 12u) ^ (y << 16u))));
    acc = (acc ^ (acc & acc));
    acc = (acc ^ ((y & x) >> 9u));
    return acc;
}
