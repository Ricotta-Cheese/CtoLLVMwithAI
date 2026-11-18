_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (acc & 7u));
        acc = (acc ^ ((x >> 15u) >> 28u));
    } else {
        acc = (acc ^ ((acc * y) + (3u + y)));
        acc = (acc ^ (y - y));
    }
    acc = (acc ^ (acc + (y << 30u)));
    return acc;
}
