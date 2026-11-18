_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - ((y * y) + (2u + acc)));
    acc = (acc * (((x - 0u) + (3u * 0u)) - 2208342363u));
    acc = (acc - x);
    return acc;
}
