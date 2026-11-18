_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (((y & acc) & 15u) & ((x + x) + (acc | y))));
        acc = (acc ^ ((acc & y) >> 14u));
    }
    acc = (acc ^ (y ^ (7u + acc)));
    return acc;
}
