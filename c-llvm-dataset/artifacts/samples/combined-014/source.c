_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i ^ i));
        acc = (acc ^ ((x << 29u) << 5u));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ (7u * (x ^ y)));
            acc = (acc ^ (((y << 14u) | (x * 31u)) ^ (x ^ (2u | acc))));
        } else {
            acc = (acc ^ (((acc - 2u) & (acc - i)) + x));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (2u * (x * 31u)));
        acc = (acc ^ (acc ^ y));
    } else {
        acc = (acc ^ (acc * 16u));
    }
    return acc;
}
