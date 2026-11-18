_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * (y - (4294967295u + x)));
    acc = (acc + ((y - y) * acc));
    acc = (acc - (0u * 7u));
    return acc;
}
