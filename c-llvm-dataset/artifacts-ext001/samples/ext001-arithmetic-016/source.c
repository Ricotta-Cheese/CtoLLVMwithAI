_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - ((x + acc) + (acc - acc)));
    acc = (acc * ((x - 1u) + (acc + x)));
    acc = (acc - (((acc - y) * 31u) + ((acc * acc) * (1u * x))));
    return acc;
}
