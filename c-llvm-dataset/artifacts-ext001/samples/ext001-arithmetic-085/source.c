_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - ((x - (acc + x)) - y));
    acc = (acc + (0u - y));
    acc = (acc * (y - x));
    acc = (acc + (4294967295u - 2u));
    return acc;
}
