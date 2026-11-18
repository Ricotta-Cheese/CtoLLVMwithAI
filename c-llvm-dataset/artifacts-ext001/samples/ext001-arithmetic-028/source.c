_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc - ((acc - (1u - y)) + ((y * 4294967295u) + (1u + acc))));
    acc = (acc + (y * (y * 0u)));
    acc = (acc * (31u - 3u));
    return acc;
}
