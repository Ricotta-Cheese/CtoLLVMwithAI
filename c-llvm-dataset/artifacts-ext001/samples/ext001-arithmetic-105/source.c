_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - ((16u * x) - (3u + 1u)));
    acc = (acc - (16u * (y + 4294967295u)));
    acc = (acc * (((y - y) * (acc + y)) + ((7u + 0u) - (y * y))));
    acc = (acc * (acc - (344333132u * 15u)));
    return acc;
}
