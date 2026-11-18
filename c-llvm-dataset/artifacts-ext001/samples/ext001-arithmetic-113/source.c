_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - acc);
    acc = (acc - ((acc - y) * ((1u * 2u) - (y * x))));
    acc = (acc * (1u * 15u));
    return acc;
}
