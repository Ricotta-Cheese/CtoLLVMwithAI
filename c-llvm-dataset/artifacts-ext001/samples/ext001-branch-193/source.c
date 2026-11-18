_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((acc + x) >> 5u));
    } else {
        acc = (acc ^ (((y << 6u) ^ (acc >> 12u)) & ((y & 16u) << 24u)));
        acc = (acc ^ ((y & x) | (y + x)));
    }
    acc = (acc ^ x);
    return acc;
}
