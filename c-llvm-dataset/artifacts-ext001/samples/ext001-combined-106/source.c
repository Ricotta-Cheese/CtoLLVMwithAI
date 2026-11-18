_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ x);
        acc = (acc ^ (((x ^ x) >> 7u) >> 17u));
        acc = (acc ^ (((i - i) | (y & i)) + ((y + x) - (i - acc))));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ (i - i));
            acc = (acc ^ ((y ^ i) & (15u - y)));
        } else {
            acc = (acc ^ ((x << 28u) << 4u));
            acc = (acc ^ (((i >> 21u) & (0u >> 4u)) | ((x ^ acc) | (y - 16u))));
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (acc + (x << 20u)));
        acc = (acc ^ (0u + (acc >> 2u)));
    } else {
        acc = (acc ^ ((31u >> 12u) | ((16u * acc) - 3u)));
    }
    return acc;
}
