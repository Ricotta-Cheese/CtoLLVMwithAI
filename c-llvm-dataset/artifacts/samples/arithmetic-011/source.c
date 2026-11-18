_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - ((y + y) * (y + acc)));
    acc = (acc * ((2306961561u + y) * (2u * y)));
    acc = (acc - ((acc * acc) * x));
    acc = (acc + ((x + y) + (acc - 3u)));
    return acc;
}
