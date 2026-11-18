_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((acc << 26u) * (15u * 2u)));
        acc = (acc ^ ((acc * y) << 20u));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ ((0u ^ acc) + (x + 1524942019u)));
    }
    acc = (acc ^ ((acc - y) * y));
    return acc;
}
