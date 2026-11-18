_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (y >> 14u));
        acc = (acc ^ (((y ^ acc) << 31u) >> 6u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (2u + 15u));
    }
    acc = (acc ^ ((0u + x) + (y << 15u)));
    return acc;
}
