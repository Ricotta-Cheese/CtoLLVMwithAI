_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + (x + y));
    acc = (acc - ((y + (acc + y)) - (acc * (acc + acc))));
    acc = (acc * (((4294967295u * y) * (x + y)) + ((y - 31u) * y)));
    return acc;
}
