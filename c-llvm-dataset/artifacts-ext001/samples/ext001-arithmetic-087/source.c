_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (acc - 3u));
    acc = (acc + ((1u + y) * (acc * x)));
    acc = (acc * (((y * 16u) + (x - acc)) + (15u * 3u)));
    return acc;
}
