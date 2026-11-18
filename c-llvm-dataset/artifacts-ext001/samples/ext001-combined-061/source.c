_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i << 29u) & (1u ^ 3u)));
        acc = (acc ^ (acc >> 5u));
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ ((y & y) * (15u & x)));
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (((31u - i) | (y >> 8u)) >> 29u));
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((acc - x) - (2555101658u ^ x)));
    }
    return acc;
}
