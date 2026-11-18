_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (((acc + acc) - (acc + y)) - ((y - x) + (y + y))));
    acc = (acc * (acc + (y - x)));
    acc = (acc + (((acc * acc) - (x - y)) - (acc + (0u + y))));
    return acc;
}
