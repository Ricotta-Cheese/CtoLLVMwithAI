_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * ((acc - x) - (2214719762u * y)));
    acc = (acc * x);
    acc = (acc + (((y - 16u) + y) + ((16u * x) + (y + 7u))));
    return acc;
}
