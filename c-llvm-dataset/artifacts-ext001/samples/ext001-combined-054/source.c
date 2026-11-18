_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i | i));
        acc = (acc ^ (acc ^ 3u));
        acc = (acc ^ ((x * 3u) - (i * acc)));
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ (acc | i));
        } else {
            acc = (acc ^ (y * x));
            acc = (acc ^ ((0u << 29u) - (x - i)));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((1u & acc) | y));
        acc = (acc ^ (((acc - 4294967295u) ^ (y & 845445268u)) | (31u ^ (y ^ 7u))));
    } else {
        acc = (acc ^ ((y ^ acc) << 7u));
    }
    return acc;
}
