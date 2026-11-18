_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - (x + 16u));
    acc = (acc + (((31u + x) * (acc - x)) + ((y * y) + (x + 2u))));
    acc = (acc * ((16u - y) * 3u));
    return acc;
}
