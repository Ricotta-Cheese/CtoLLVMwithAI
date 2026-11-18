_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (31u >> 5u));
        acc = (acc ^ ((x - acc) ^ (x | x)));
    } else {
        acc = (acc ^ (((y & x) << 15u) + ((x - acc) & (y & 0u))));
        acc = (acc ^ ((acc + y) >> 21u));
    }
    acc = (acc ^ ((31u ^ y) & (acc ^ y)));
    return acc;
}
