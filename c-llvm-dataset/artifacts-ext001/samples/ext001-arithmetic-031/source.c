_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - (acc + x));
    acc = (acc + 16u);
    acc = (acc + 2917114019u);
    acc = (acc + (((y - y) * (4294967295u * y)) * (acc + (acc + acc))));
    return acc;
}
