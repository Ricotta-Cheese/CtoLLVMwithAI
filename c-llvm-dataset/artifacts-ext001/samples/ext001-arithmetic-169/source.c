_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + 16u);
    acc = (acc - ((acc + 1722336406u) - (x - 15u)));
    acc = (acc * ((x * y) - (acc - acc)));
    acc = (acc * (y + x));
    return acc;
}
