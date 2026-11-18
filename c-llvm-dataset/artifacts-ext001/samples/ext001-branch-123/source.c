_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (y * x));
    } else {
        acc = (acc ^ ((acc & y) ^ (x & 16u)));
        acc = (acc ^ (((acc + acc) << 4u) * ((y & 7u) ^ (x << 25u))));
    }
    acc = (acc ^ ((acc | y) >> 17u));
    return acc;
}
