_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i - y));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ ((1u + y) >> 14u));
        } else {
            acc = (acc ^ ((acc & i) * i));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (((y + y) | (1u - acc)) >> 30u));
        acc = (acc ^ (x + y));
    } else {
        acc = (acc ^ (((4294967295u * x) ^ (x | y)) | ((y ^ y) * (7u << 21u))));
        acc = (acc ^ (acc << 22u));
    }
    return acc;
}
