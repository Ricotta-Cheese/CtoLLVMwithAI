_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ 3u);
        acc = (acc ^ ((acc - 1166739319u) * (acc - acc)));
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (acc + (31u | acc)));
            acc = (acc ^ (acc ^ acc));
        } else {
            acc = (acc ^ (((acc ^ x) + (x + i)) + x));
            acc = (acc ^ ((acc >> 1u) & ((x | acc) >> 7u)));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (4294967295u ^ y));
        acc = (acc ^ x);
    }
    return acc;
}
