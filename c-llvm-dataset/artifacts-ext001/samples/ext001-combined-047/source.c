_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x << 26u) << 10u) ^ (acc ^ (i - x))));
        acc = (acc ^ (i & x));
        if (((((x ^ y) ^ i) & 1073741824u) == 0u)) {
            acc = (acc ^ (y - 3988803675u));
            acc = (acc ^ ((2u << 8u) >> 29u));
        } else {
            acc = (acc ^ (16u << 31u));
            acc = (acc ^ (3u ^ (i + i)));
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (x - 2u));
    } else {
        acc = (acc ^ ((0u & 3u) & ((4294967295u - y) ^ (y - acc))));
        acc = (acc ^ y);
    }
    return acc;
}
