_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x | acc) & (y * 4294967295u)));
        acc = (acc ^ (i & ((3680261313u >> 6u) | (acc << 17u))));
        acc = (acc ^ ((x ^ (acc * y)) | ((16u ^ 16u) * (y >> 16u))));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ (acc & x));
            acc = (acc ^ ((3u >> 2u) | ((acc ^ 3942186614u) - (835966022u + y))));
        } else {
            acc = (acc ^ (15u | 2u));
            acc = (acc ^ ((i | i) & (y ^ 3u)));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ ((acc - 31u) * (y & 3u)));
    } else {
        acc = (acc ^ (x | 3u));
    }
    return acc;
}
