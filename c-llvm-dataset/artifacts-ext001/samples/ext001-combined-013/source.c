_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 31u);
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ (y + ((acc & y) & (i << 15u))));
            acc = (acc ^ (((acc ^ 4294967295u) & 7u) + (i - (i | i))));
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (((3u & acc) + (16u - y)) & ((acc >> 11u) << 7u)));
        acc = (acc ^ (acc + y));
    }
    return acc;
}
