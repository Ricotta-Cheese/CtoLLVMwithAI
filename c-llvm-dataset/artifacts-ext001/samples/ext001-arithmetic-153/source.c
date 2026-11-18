_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc * ((y - (16u - acc)) * ((y + 3u) - (acc + 3176343603u))));
    acc = (acc + x);
    acc = (acc + (x - (2u - y)));
    acc = (acc * 7u);
    return acc;
}
