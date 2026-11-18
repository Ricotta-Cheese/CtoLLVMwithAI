_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x + acc) >> 25u) << 8u));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ (((4294967295u * y) ^ acc) & ((y - y) ^ (y & x))));
        } else {
            acc = (acc ^ ((y | y) >> 17u));
            acc = (acc ^ (((16u & x) | (i | 2u)) | ((3u & acc) | (acc - acc))));
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (2u << 19u));
        acc = (acc ^ (y >> 25u));
    } else {
        acc = (acc ^ ((acc - y) << 30u));
    }
    return acc;
}
