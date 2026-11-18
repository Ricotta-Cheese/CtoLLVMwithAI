_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (acc >> 14u));
        acc = (acc ^ (((15u & y) ^ (x * 2u)) - ((acc + 0u) * (y >> 28u))));
    } else {
        acc = (acc ^ ((acc - x) >> 1u));
    }
    acc = (acc ^ y);
    return acc;
}
