_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - ((acc * 3u) - (acc + y)));
    acc = (acc + ((x + (acc * acc)) * ((x * 16u) + (4294967295u * x))));
    acc = (acc - (y * (x + 4294967295u)));
    return acc;
}
