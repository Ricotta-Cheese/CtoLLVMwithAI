_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (((4294967295u + y) >> 26u) << 15u));
    } else {
        acc = (acc ^ (x + 1u));
    }
    acc = (acc ^ (acc & x));
    return acc;
}
