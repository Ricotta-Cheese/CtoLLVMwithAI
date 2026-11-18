_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (((x - 3u) + (y & acc)) * ((y & x) << 15u)));
    } else {
        acc = (acc ^ (((16u * acc) << 15u) - ((acc ^ y) * (x & acc))));
        acc = (acc ^ (((x | 7u) | (acc ^ acc)) << 9u));
    }
    acc = (acc ^ x);
    return acc;
}
