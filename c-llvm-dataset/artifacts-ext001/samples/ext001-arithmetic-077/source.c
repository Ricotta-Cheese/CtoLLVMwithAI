_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (16u - (x - acc)));
    acc = (acc + (y - (acc - (3421506940u * acc))));
    acc = (acc * (2u - acc));
    return acc;
}
