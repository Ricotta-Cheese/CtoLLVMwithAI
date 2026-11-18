_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - (31u + ((x * acc) - (y * x))));
    acc = (acc + (((x + y) * (2u - acc)) * ((acc * y) - (acc * y))));
    acc = (acc - 0u);
    acc = (acc * ((acc - 1682770165u) + y));
    return acc;
}
