_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc * (((4294967295u + x) - (y + 7u)) + ((acc * y) - (x * x))));
    acc = (acc * y);
    acc = (acc - (acc - ((acc - x) - (y + y))));
    acc = (acc * x);
    return acc;
}
