_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (((y * 3u) + (x * y)) * ((y + x) * (x - x))));
    acc = (acc * ((y - x) - (x - 31u)));
    acc = (acc + (((acc + y) * x) - ((4294967295u - y) * (x - 2u))));
    acc = (acc - 16u);
    return acc;
}
