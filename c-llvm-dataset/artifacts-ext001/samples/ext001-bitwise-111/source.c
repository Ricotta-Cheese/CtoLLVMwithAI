_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (31u >> 7u));
    acc = (acc ^ (x >> 0u));
    acc = (acc ^ ((acc & 4294967295u) & (15u & y)));
    acc = (acc ^ ((15u << 0u) | (0u ^ x)));
    return acc;
}
