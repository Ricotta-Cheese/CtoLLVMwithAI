_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((7u << 0u) & acc) & ((x << 27u) - (x ^ x))));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ (31u ^ acc));
        } else {
            acc = (acc ^ (((i + i) | (16u + i)) ^ ((i * acc) & (x | 1u))));
            acc = (acc ^ (y ^ i));
        }
    }
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (31u * x));
    } else {
        acc = (acc ^ (2367788072u | 7u));
    }
    return acc;
}
