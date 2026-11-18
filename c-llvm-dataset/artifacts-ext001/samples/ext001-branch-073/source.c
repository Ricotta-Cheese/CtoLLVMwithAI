_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (y << 28u));
    } else {
        acc = (acc ^ x);
    }
    acc = (acc ^ (((2u & acc) * (x | 1u)) + acc));
    return acc;
}
