_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc * ((31u - acc) - (x - x)));
    acc = (acc + ((x * x) - (acc + y)));
    acc = (acc + ((y - x) + (y * y)));
    acc = (acc - (4294967295u + ((acc + acc) - y)));
    return acc;
}
