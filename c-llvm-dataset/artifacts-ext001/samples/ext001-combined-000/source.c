_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc + ((acc - y) + (x >> 29u))));
        acc = (acc ^ (((y | y) ^ (16u * acc)) ^ acc));
        acc = (acc ^ 1u);
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ y);
            acc = (acc ^ ((0u ^ 15u) >> 3u));
        } else {
            acc = (acc ^ ((x * i) * (acc ^ y)));
            acc = (acc ^ (((acc & y) - (acc - x)) - acc));
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (x & (y - 7u)));
        acc = (acc ^ ((1u ^ y) << 15u));
    }
    return acc;
}
