_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i - x));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ (((acc >> 30u) ^ (i | acc)) ^ ((acc << 19u) >> 14u)));
        } else {
            acc = (acc ^ 31u);
        }
    }
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ ((x << 30u) + (x ^ y)));
    } else {
        acc = (acc ^ (0u | y));
    }
    return acc;
}
