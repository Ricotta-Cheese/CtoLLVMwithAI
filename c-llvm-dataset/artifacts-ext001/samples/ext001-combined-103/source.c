_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y >> 18u) + (x & acc)) | (i * (31u | acc))));
        acc = (acc ^ 0u);
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (((x + y) ^ (x & 0u)) + ((acc + y) - 7u)));
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (16u & (i >> 14u)));
            acc = (acc ^ (x & x));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y + y));
    } else {
        acc = (acc ^ (((y << 24u) ^ (x | y)) << 10u));
        acc = (acc ^ ((3u << 25u) ^ (x | x)));
    }
    return acc;
}
