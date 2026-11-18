_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - ((acc * y) - (x + x)));
    acc = (acc + (y - acc));
    acc = (acc + ((1u + y) * (acc - 1667303720u)));
    return acc;
}
