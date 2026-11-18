_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        acc = (acc ^ x);
        acc = (acc ^ ((y + (acc >> 20u)) | ((i + acc) - 3u)));
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ (i >> 26u));
            acc = (acc ^ 15u);
        } else {
            acc = (acc ^ (((x ^ acc) | (4294967295u + acc)) & ((i & x) - (2u + 7u))));
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (((x | y) * (acc & acc)) | ((acc | y) << 5u)));
    } else {
        acc = (acc ^ (acc ^ 1u));
        acc = (acc ^ (y - y));
    }
    return acc;
}
