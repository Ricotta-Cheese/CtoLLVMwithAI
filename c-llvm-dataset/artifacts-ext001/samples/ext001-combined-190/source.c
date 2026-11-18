_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc >> 31u) | (3u ^ acc)));
        acc = (acc ^ ((acc << 14u) >> 6u));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (((acc * acc) ^ (y & acc)) - ((0u << 6u) & (i ^ x))));
        } else {
            acc = (acc ^ ((y + (x >> 2u)) & ((y >> 0u) ^ (31u << 20u))));
            acc = (acc ^ (((7u << 27u) * (y + acc)) | ((i - 4294967295u) & (i * x))));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (((acc ^ acc) << 12u) << 3u));
    } else {
        acc = (acc ^ (acc >> 4u));
    }
    return acc;
}
