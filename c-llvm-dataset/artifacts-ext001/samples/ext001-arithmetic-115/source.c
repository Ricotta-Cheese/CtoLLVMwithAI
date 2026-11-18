_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + (y * ((3u + y) + (2361885024u - y))));
    acc = (acc * y);
    acc = (acc * ((y + x) - (3u * 638200603u)));
    return acc;
}
