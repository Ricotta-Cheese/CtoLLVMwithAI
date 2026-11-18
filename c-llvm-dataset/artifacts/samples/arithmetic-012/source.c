_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - (y - y));
    acc = (acc * ((x - acc) + (3u * x)));
    acc = (acc - ((0u + y) * (4294967295u + 1u)));
    return acc;
}
