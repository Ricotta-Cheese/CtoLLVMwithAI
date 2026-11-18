_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + ((acc - 4294967295u) * (x * 15u)));
    acc = (acc - (7u + ((x - acc) - (3u + acc))));
    acc = (acc * ((4294967295u - acc) * (x * y)));
    acc = (acc + (1u + 4294967295u));
    return acc;
}
