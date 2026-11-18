_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (x - ((acc - acc) * (y - y))));
    acc = (acc * ((acc + 7u) - (1u - acc)));
    acc = (acc - (31u * ((x * y) * (y + y))));
    return acc;
}
