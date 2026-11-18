_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (((15u + 7u) + (x * y)) * (3u * (1u - 1u))));
    acc = (acc - ((acc - x) * (4294967295u + y)));
    acc = (acc - ((x * 1u) - (acc * acc)));
    acc = (acc - (y * (7u + acc)));
    return acc;
}
