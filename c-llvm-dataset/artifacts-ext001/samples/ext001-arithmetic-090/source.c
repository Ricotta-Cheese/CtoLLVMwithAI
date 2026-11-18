_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * ((y - 7u) + (x - 2u)));
    acc = (acc + ((acc - (acc - acc)) + ((2u - x) * (x + x))));
    acc = (acc + (15u + x));
    acc = (acc + ((acc * 1325891087u) - (y * y)));
    return acc;
}
