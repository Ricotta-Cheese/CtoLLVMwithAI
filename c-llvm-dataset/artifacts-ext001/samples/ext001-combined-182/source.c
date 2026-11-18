_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc >> 21u) + (x * i)));
        acc = (acc ^ (acc * acc));
        acc = (acc ^ (3u | y));
        if (((((x ^ y) ^ i) & 128u) == 0u)) {
            acc = (acc ^ (2u << 31u));
        } else {
            acc = (acc ^ ((acc + 7u) | i));
            acc = (acc ^ (acc * (i ^ y)));
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (y & 7u));
    } else {
        acc = (acc ^ ((acc & y) << 16u));
    }
    return acc;
}
