_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ ((0u & 15u) >> 14u));
    acc = (acc ^ y);
    acc = (acc ^ (((y & 0u) << 12u) << 12u));
    acc = (acc ^ (y << 13u));
    return acc;
}
