_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - (((2u + 16u) + (x + y)) + 1429132094u));
    acc = (acc + (y - y));
    return acc;
}
