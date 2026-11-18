_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x + i) - acc));
        if (((((x ^ y) ^ i) & 67108864u) == 0u)) {
            acc = (acc ^ (((y << 13u) ^ (i * y)) + ((acc | acc) & (x << 7u))));
            acc = (acc ^ (i ^ acc));
        } else {
            acc = (acc ^ x);
            acc = (acc ^ ((acc | (acc - 4294967295u)) + ((i - i) - (3519917366u | y))));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (((acc ^ y) ^ 3463269187u) - ((y & acc) << 2u)));
    } else {
        acc = (acc ^ ((2u >> 2u) * (acc * acc)));
    }
    return acc;
}
