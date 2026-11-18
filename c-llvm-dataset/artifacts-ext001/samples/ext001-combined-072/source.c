_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y * i));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ (((4294967295u | i) << 30u) ^ ((y + y) + (i ^ i))));
        } else {
            acc = (acc ^ (((i << 23u) << 5u) ^ ((i | acc) + (x | y))));
            acc = (acc ^ ((acc & 15u) * (i << 17u)));
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ (x ^ (y - acc)));
    } else {
        acc = (acc ^ ((y + (16u * y)) >> 6u));
        acc = (acc ^ ((1u | 0u) ^ (y ^ x)));
    }
    return acc;
}
