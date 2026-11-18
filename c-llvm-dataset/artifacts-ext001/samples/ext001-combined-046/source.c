_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((4294967295u | x) << 23u));
        acc = (acc ^ (x >> 29u));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (((y ^ 3u) | (x & y)) + ((0u << 7u) << 29u)));
        } else {
            acc = (acc ^ ((i | x) + (x & x)));
            acc = (acc ^ ((3u & x) - ((acc | 158644098u) - (31u + x))));
        }
    }
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ ((x >> 20u) & acc));
        acc = (acc ^ (3u * acc));
    } else {
        acc = (acc ^ (acc ^ ((x & 3u) * 3u)));
    }
    return acc;
}
