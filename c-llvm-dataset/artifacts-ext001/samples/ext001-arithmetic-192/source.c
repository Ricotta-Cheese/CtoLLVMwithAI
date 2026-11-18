_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + (y * ((acc * y) * (7u - x))));
    acc = (acc - (((x + 0u) + (x * x)) + ((3u - 2591682220u) + (1u + 2u))));
    return acc;
}
