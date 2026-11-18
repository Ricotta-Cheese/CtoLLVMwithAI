_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + ((3u * y) * (x * 2771197895u)));
    acc = (acc - (((y - y) * (y * acc)) * 4294967295u));
    acc = (acc * (((acc - 7u) - (3452376741u - x)) + ((y - x) + (x * x))));
    acc = (acc - (16u * x));
    return acc;
}
