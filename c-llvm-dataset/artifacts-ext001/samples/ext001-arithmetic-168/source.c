_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - (y + (x + 2u)));
    acc = (acc * ((3u - y) + y));
    acc = (acc * (((7u - acc) + (3u - x)) + x));
    acc = (acc - (4294967295u + (acc * 0u)));
    return acc;
}
