_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + y);
    acc = (acc + (((y - acc) + (acc + acc)) * (x - (x + y))));
    acc = (acc - (3716036727u * acc));
    acc = (acc - (y + y));
    return acc;
}
