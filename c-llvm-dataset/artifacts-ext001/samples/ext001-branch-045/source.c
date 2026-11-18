_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ ((acc * acc) >> 10u));
    } else {
        acc = (acc ^ ((2u * 3119630395u) - (acc >> 21u)));
        acc = (acc ^ (x >> 21u));
    }
    acc = (acc ^ (((y & acc) | (x * y)) << 14u));
    return acc;
}
