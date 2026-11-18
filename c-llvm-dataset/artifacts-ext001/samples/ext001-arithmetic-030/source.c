_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - ((y - y) - (acc * x)));
    acc = (acc - ((x - y) - (y - x)));
    acc = (acc - (acc - ((4294967295u - x) * (y * x))));
    acc = (acc + ((y * (x + y)) + acc));
    return acc;
}
