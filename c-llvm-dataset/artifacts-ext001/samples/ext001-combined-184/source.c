_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y >> 20u));
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ x);
        } else {
            acc = (acc ^ ((1u << 14u) & (3233913938u * 732800254u)));
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (((1u >> 13u) << 13u) & ((x - 31u) * (y >> 8u))));
    } else {
        acc = (acc ^ (acc - acc));
    }
    return acc;
}
