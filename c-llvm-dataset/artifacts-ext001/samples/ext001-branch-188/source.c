_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ ((1u * 31u) & (31u - 7u)));
    } else {
        acc = (acc ^ (y - acc));
        acc = (acc ^ (0u - ((x << 23u) ^ (7u - 4294967295u))));
    }
    acc = (acc ^ ((acc | y) - (y >> 27u)));
    return acc;
}
