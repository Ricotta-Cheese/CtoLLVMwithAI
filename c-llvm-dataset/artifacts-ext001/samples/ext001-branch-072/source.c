_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (x >> 1u));
        acc = (acc ^ (y + 1u));
    } else {
        acc = (acc ^ ((y - acc) << 13u));
    }
    acc = (acc ^ ((15u ^ x) | (acc >> 27u)));
    return acc;
}
