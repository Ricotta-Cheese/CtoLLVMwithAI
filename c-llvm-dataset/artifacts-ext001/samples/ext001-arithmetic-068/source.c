_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - acc);
    acc = (acc * ((acc * (y * y)) + (y * (y + 4294967295u))));
    acc = (acc + (1278106322u - y));
    acc = (acc * ((x * 4294967295u) * x));
    return acc;
}
