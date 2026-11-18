_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc * (((x - acc) + (x + y)) + y));
    acc = (acc * 1u);
    acc = (acc + (x + 7u));
    acc = (acc * (((y - 7u) + (y * acc)) + ((4294967295u * 183171038u) * (y * y))));
    return acc;
}
