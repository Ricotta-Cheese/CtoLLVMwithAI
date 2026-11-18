_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (acc * ((acc * y) - (x * x))));
    acc = (acc - (((acc - x) - (589803685u + x)) - 2u));
    acc = (acc - ((acc * acc) + 4294967295u));
    acc = (acc + (((acc + x) + (acc - y)) + (3u - (y * x))));
    return acc;
}
