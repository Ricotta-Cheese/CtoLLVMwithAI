_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + ((acc - acc) - (3995935930u * y)));
    acc = (acc * (((x - 3u) - (x - acc)) + ((acc - 3761142520u) + (acc - y))));
    return acc;
}
