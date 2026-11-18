_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + x);
    acc = (acc * (((1343788714u - x) + (y + y)) + ((x * y) * (16u - x))));
    acc = (acc - ((x * acc) + (y - 4294967295u)));
    acc = (acc - (((acc - y) - (y * x)) * (0u * (7u - x))));
    return acc;
}
