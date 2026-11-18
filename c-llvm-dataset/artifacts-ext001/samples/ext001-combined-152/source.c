_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x | y));
        acc = (acc ^ (((1u * acc) | (787629723u | y)) | ((3u >> 26u) >> 19u)));
        acc = (acc ^ (((acc << 13u) & y) & ((x & 1u) & (y & y))));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ ((15u ^ i) ^ (0u >> 19u)));
            acc = (acc ^ (y | x));
        } else {
            acc = (acc ^ (31u ^ y));
            acc = (acc ^ ((0u >> 26u) * (acc & y)));
        }
    }
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
