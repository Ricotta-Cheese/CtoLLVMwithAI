_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ ((acc >> 2u) ^ (y | 4294967295u)));
    } else {
        acc = (acc ^ (((4294967295u | x) * y) ^ ((acc + acc) - acc)));
        acc = (acc ^ y);
    }
    acc = (acc ^ (y << 22u));
    return acc;
}
