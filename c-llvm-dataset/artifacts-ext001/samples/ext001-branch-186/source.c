_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ ((acc ^ acc) << 5u));
    } else {
        acc = (acc ^ ((31u << 23u) << 2u));
        acc = (acc ^ (x << 13u));
    }
    acc = (acc ^ y);
    return acc;
}
