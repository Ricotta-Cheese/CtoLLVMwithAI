_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * ((x - 0u) + (x - 16u)));
    acc = (acc + ((3u - 4294967295u) - (y + x)));
    acc = (acc - (x - x));
    return acc;
}
