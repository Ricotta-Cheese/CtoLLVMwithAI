_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ (((i ^ i) - (16u + 3u)) ^ ((16u * y) * (i ^ 3u))));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ (y + i));
            acc = (acc ^ ((i & x) & (acc >> 23u)));
        } else {
            acc = (acc ^ (i | 0u));
            acc = (acc ^ (4294967295u >> 4u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ ((0u + x) << 23u));
    } else {
        acc = (acc ^ (((x | acc) | x) ^ ((y << 3u) & (x >> 10u))));
        acc = (acc ^ (y ^ 0u));
    }
    return acc;
}
