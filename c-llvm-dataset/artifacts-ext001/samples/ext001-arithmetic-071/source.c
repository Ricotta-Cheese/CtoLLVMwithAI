_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + ((x + y) + (y - 7u)));
    acc = (acc - (((y - 7u) + (acc - acc)) * acc));
    acc = (acc * acc);
    acc = (acc * (((acc + 0u) + y) - ((acc + 7u) - x)));
    return acc;
}
