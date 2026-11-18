_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (((4294967295u * y) + (31u + x)) * ((y + y) * (x - x))));
    acc = (acc - ((y * x) * (acc - y)));
    acc = (acc * ((acc + x) * (x * 31u)));
    return acc;
}
