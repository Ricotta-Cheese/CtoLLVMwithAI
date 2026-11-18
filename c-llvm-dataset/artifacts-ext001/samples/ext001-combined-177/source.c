_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x & 3530382700u) >> 3u));
        acc = (acc ^ (i >> 16u));
        acc = (acc ^ (i << 0u));
        if (((((x ^ y) ^ i) & 8192u) == 0u)) {
            acc = (acc ^ (x + 7u));
        } else {
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ ((x + x) >> 13u));
        acc = (acc ^ (7u - acc));
    } else {
        acc = (acc ^ ((acc * 1u) >> 17u));
    }
    return acc;
}
