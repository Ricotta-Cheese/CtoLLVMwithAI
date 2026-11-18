_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i ^ (15u * acc)) ^ 7u));
        acc = (acc ^ (i << 20u));
        if (((((x ^ y) ^ i) & 2048u) == 0u)) {
            acc = (acc ^ (i * 886819705u));
        } else {
            acc = (acc ^ (y & y));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (((x - 1u) - (acc & x)) * ((y + x) - (x << 27u))));
        acc = (acc ^ ((4294967295u << 27u) >> 24u));
    } else {
        acc = (acc ^ (acc & ((15u ^ 31u) << 22u)));
        acc = (acc ^ x);
    }
    return acc;
}
