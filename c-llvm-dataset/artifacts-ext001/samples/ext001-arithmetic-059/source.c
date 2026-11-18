_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + y);
    acc = (acc * 31u);
    acc = (acc + (4294967295u + (1u - x)));
    acc = (acc - (((y * acc) - acc) - ((y + 3u) * y)));
    return acc;
}
