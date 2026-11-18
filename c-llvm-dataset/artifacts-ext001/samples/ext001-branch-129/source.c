_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ ((x << 21u) - x));
        acc = (acc ^ (31u - acc));
    } else {
        acc = (acc ^ ((acc - 1u) << 19u));
    }
    acc = (acc ^ (((x >> 8u) + (7u << 23u)) * ((y << 20u) >> 17u)));
    return acc;
}
