_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y & y) & (7u ^ y)) | 272286416u));
        acc = (acc ^ (16u >> 16u));
        if (((((x ^ y) ^ i) & 67108864u) == 0u)) {
            acc = (acc ^ 7u);
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (y | i));
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (y ^ y));
    } else {
        acc = (acc ^ (((7u + acc) ^ y) + (4294967295u * (y ^ acc))));
        acc = (acc ^ (y << 3u));
    }
    return acc;
}
