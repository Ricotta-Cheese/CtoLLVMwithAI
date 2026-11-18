_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + (y * 3966545947u));
    acc = (acc + (((x * y) + (0u * x)) - ((31u * 31u) * y)));
    return acc;
}
