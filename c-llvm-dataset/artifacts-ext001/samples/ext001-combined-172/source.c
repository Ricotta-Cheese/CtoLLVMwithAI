_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc >> 20u));
        acc = (acc ^ (i | x));
        acc = (acc ^ (acc - i));
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ (i - y));
            acc = (acc ^ (y | (i ^ i)));
        } else {
            acc = (acc ^ ((1u ^ acc) & (acc << 15u)));
        }
    }
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ (((acc & acc) + (x | 31u)) >> 22u));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
