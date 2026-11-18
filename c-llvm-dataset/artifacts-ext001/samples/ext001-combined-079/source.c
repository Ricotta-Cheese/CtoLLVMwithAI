_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i + 1u) | (y + x)) + ((x ^ y) + i)));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ i);
            acc = (acc ^ 15u);
        } else {
            acc = (acc ^ (((x | y) << 7u) >> 2u));
            acc = (acc ^ ((i & 1u) * acc));
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ ((x & (x + 433612104u)) ^ y));
    } else {
        acc = (acc ^ (x & y));
        acc = (acc ^ (((acc - x) - 15u) >> 6u));
    }
    return acc;
}
