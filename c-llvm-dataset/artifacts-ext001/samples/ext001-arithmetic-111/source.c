_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + ((2u - acc) * (acc + y)));
    acc = (acc * acc);
    acc = (acc * x);
    acc = (acc - (31u - acc));
    return acc;
}
