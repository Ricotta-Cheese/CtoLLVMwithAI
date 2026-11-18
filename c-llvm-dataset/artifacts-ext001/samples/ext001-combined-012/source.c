_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        acc = (acc ^ (i * x));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ 15u);
        } else {
            acc = (acc ^ 16u);
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ ((x + acc) | (y - y)));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ ((x & 7u) << 3u));
    }
    return acc;
}
