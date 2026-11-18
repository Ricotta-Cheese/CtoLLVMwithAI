_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (x - 16u));
    acc = (acc - ((acc - acc) * (y * 143422531u)));
    acc = (acc - ((y + x) + (1u - y)));
    acc = (acc * ((y * x) + (acc * acc)));
    return acc;
}
