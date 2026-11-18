_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (x * y));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((acc + x) << 11u));
    }
    acc = (acc ^ (((acc | x) - (2u * acc)) ^ ((acc * 0u) & (y | y))));
    return acc;
}
