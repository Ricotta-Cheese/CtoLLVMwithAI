_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (7u * acc));
        acc = (acc ^ ((y & acc) + (i ^ i)));
        if (((((x ^ y) ^ i) & 1u) == 0u)) {
            acc = (acc ^ (y | (i & (y | i))));
            acc = (acc ^ (y & 7u));
        } else {
            acc = (acc ^ ((acc & y) << 18u));
            acc = (acc ^ (((acc | 3125804698u) >> 18u) - ((y & acc) | (acc >> 24u))));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (y | x));
        acc = (acc ^ ((x + x) | acc));
    } else {
        acc = (acc ^ (((acc | x) & (1u | acc)) ^ x));
    }
    return acc;
}
