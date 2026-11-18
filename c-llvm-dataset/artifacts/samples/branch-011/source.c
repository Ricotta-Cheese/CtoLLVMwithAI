_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (y * 4294967295u));
    } else {
        acc = (acc ^ ((acc | acc) - (2u & 2u)));
        acc = (acc ^ ((x >> 7u) | (y * 31u)));
    }
    acc = (acc ^ (((acc >> 8u) & (4294967295u | x)) & ((x ^ acc) - (1u << 23u))));
    return acc;
}
