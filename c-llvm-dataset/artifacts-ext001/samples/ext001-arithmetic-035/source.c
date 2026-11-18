_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - (((31u - y) + (y - 4294967295u)) * (y - (y + x))));
    acc = (acc - (acc * x));
    acc = (acc + (31u - (acc - 3u)));
    acc = (acc + (((y + y) - (x - y)) * ((acc - 1u) - x)));
    return acc;
}
