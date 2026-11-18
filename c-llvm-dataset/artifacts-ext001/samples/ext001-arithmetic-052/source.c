_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (((acc * 16u) * 31u) - ((y * 7u) + acc)));
    acc = (acc * y);
    acc = (acc - ((1u - (y - y)) + (acc - (acc * 2u))));
    acc = (acc + (acc - acc));
    return acc;
}
