_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (y * x));
    } else {
        acc = (acc ^ ((y >> 10u) + 15u));
        acc = (acc ^ (((1u << 26u) * (4294967295u & 7u)) << 10u));
    }
    acc = (acc ^ (x * y));
    return acc;
}
