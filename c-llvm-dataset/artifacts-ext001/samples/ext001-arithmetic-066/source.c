_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + (y * (y + y)));
    acc = (acc * (((acc - acc) + (y - y)) - ((16u * x) * (x - acc))));
    acc = (acc * ((819068613u * acc) - (7u * y)));
    return acc;
}
