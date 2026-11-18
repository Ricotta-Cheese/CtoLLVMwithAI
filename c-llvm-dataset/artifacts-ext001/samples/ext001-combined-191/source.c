_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y & (x * 2u)));
        acc = (acc ^ ((acc * acc) & (x << 28u)));
        if (((((x ^ y) ^ i) & 134217728u) == 0u)) {
            acc = (acc ^ (((2077801678u * 4294967295u) - (acc >> 2u)) | ((i - 16u) & (acc - x))));
        } else {
            acc = (acc ^ ((x * acc) | (2u + 15u)));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (x & ((y | acc) ^ (y + x))));
    } else {
        acc = (acc ^ ((x - y) * (y | acc)));
    }
    return acc;
}
