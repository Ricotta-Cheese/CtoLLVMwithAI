_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + x);
    acc = (acc + ((7u - y) - (acc + 16u)));
    acc = (acc + ((4294967295u + acc) - (acc - x)));
    return acc;
}
