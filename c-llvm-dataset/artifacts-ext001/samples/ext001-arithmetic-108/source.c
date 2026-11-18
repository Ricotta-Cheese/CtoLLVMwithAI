_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * x);
    acc = (acc * ((y - y) - (755325502u + 1161295691u)));
    acc = (acc + y);
    acc = (acc * (y * (acc - y)));
    return acc;
}
