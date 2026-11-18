_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (0u + ((x * y) + (y + 0u))));
    acc = (acc - y);
    acc = (acc - (2u + x));
    acc = (acc + (((y * 7u) * (x * x)) * acc));
    return acc;
}
