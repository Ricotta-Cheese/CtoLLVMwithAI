_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (y + ((acc * x) * (15u * 7u))));
    acc = (acc + ((acc * acc) - (16u * x)));
    acc = (acc + (acc - 250980685u));
    acc = (acc * (y - acc));
    return acc;
}
