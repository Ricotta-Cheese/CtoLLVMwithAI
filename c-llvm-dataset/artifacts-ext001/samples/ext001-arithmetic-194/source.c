_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + ((y - 2u) + (x + 15u)));
    acc = (acc * (acc * y));
    acc = (acc - y);
    return acc;
}
