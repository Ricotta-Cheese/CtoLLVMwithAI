_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (x * acc));
    acc = (acc - ((x + acc) + (y - x)));
    acc = (acc + (x + y));
    return acc;
}
