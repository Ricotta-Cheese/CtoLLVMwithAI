_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (x * x));
    } else {
        acc = (acc ^ (15u - (3u - x)));
    }
    acc = (acc ^ (acc & ((x >> 25u) | (x << 5u))));
    return acc;
}
