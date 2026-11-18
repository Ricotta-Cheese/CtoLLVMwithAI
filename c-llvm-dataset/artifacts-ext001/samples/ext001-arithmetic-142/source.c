_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (((y - x) + (y * x)) - ((x * acc) * (x + acc))));
    acc = (acc * (y + y));
    acc = (acc + (31u - x));
    acc = (acc + (x * 1u));
    return acc;
}
