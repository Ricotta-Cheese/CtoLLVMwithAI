_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (((acc * y) + (x - 15u)) * ((acc + x) * (acc - x))));
    acc = (acc + ((x * 0u) + (y - 7u)));
    acc = (acc * ((3u - x) * (x - y)));
    acc = (acc + (2u + y));
    return acc;
}
