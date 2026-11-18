_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - ((y * (4294967295u * y)) * ((135182705u - y) + (y * x))));
    acc = (acc + (x - x));
    acc = (acc - (((y - 2u) + (4294967295u + x)) * ((1u + acc) * (x - y))));
    acc = (acc + (((0u * acc) - (y - y)) - ((y + acc) + (acc - acc))));
    return acc;
}
