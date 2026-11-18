_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * x);
    acc = (acc + ((x - x) * (16u + 1u)));
    acc = (acc - (((16u - y) + (x - 16u)) + ((x * 3u) - (x * x))));
    return acc;
}
