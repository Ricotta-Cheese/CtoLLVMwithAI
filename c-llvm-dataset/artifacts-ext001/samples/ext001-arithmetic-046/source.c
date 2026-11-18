_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - (y - (x - x)));
    acc = (acc - (((x + x) - (x - acc)) * ((4294967295u - 1u) + (y + 4294967295u))));
    acc = (acc * (31u - y));
    acc = (acc * acc);
    return acc;
}
