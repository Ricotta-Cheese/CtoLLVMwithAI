_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - 7u);
    acc = (acc - ((y + acc) - (3u + 3061104710u)));
    acc = (acc - ((x - y) + (x - 16u)));
    return acc;
}
