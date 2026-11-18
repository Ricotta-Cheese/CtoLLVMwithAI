_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - 4294967295u);
    acc = (acc - (((x + y) - (3u * 7u)) * ((y * 0u) - (x * x))));
    acc = (acc + (acc + 1u));
    return acc;
}
