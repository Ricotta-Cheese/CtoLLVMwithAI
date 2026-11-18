_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (y >> 12u));
    acc = (acc ^ ((x >> 16u) | (y << 5u)));
    acc = (acc ^ (((16u & y) >> 13u) >> 21u));
    acc = (acc ^ (((acc & acc) << 14u) >> 25u));
    return acc;
}
