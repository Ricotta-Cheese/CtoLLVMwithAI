_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y | (y * 3u)));
        acc = (acc ^ (4294967295u + (i & 1u)));
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (i & (i >> 2u)));
        } else {
            acc = (acc ^ ((i | 15u) | (x | 16u)));
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (y + acc));
        acc = (acc ^ (y & x));
    } else {
        acc = (acc ^ ((acc & x) << 26u));
    }
    return acc;
}
