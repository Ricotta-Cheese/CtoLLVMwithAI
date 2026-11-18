_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + (((y + y) + (acc + x)) - ((3865295773u + 2u) + (y - acc))));
    acc = (acc + (y * y));
    acc = (acc + ((y + (acc - y)) - 2u));
    acc = (acc - ((3334867569u * (y + 16u)) + ((x - 3u) + (x * acc))));
    return acc;
}
