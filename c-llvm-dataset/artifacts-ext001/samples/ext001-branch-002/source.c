_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((x ^ acc) + (y & acc)));
    }
    acc = (acc ^ ((1u - 1170018842u) & (y >> 16u)));
    return acc;
}
