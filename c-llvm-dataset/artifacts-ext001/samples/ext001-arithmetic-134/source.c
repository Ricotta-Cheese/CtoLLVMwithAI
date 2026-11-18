_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (acc - y));
    acc = (acc * ((x * y) - (1u - y)));
    acc = (acc + (((0u + 7u) - (x + acc)) * 1u));
    acc = (acc - ((acc - acc) + ((y - x) * (4294967295u + y))));
    return acc;
}
