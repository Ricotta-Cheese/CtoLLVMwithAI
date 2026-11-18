_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y << 24u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ ((acc - (x << 21u)) >> 26u));
    }
    acc = (acc ^ ((31u ^ x) >> 30u));
    return acc;
}
