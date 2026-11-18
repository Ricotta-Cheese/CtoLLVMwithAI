_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (((acc & x) & (x | acc)) << 24u));
        acc = (acc ^ (((x + y) | (acc >> 30u)) ^ ((acc - 16u) ^ (y ^ x))));
    } else {
        acc = (acc ^ ((15u ^ 15u) + (x & x)));
    }
    acc = (acc ^ 3504489242u);
    return acc;
}
