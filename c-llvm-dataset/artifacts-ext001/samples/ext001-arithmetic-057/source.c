_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * ((x + x) + (y * 756678412u)));
    acc = (acc + (((x - x) + (0u + 248762802u)) - ((acc * y) - 3u)));
    acc = (acc - y);
    return acc;
}
