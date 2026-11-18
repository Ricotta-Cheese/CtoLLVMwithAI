_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (31u >> 27u));
        acc = (acc ^ i);
        acc = (acc ^ ((acc + (4294967295u << 24u)) ^ ((acc ^ 1787492097u) & (0u ^ y))));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (i | y));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (((15u & acc) * y) & ((acc << 20u) ^ (acc & 15u))));
    } else {
        acc = (acc ^ (y - acc));
    }
    return acc;
}
