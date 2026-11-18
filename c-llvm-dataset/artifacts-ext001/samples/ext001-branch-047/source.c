_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (((x & y) & (acc + x)) >> 5u));
    } else {
        acc = (acc ^ (((acc * y) - (7u | 1u)) & (x * (acc & y))));
    }
    acc = (acc ^ ((y + x) << 29u));
    return acc;
}
