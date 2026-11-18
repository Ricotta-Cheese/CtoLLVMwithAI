_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 16u);
        if (((((x ^ y) ^ i) & 1073741824u) == 0u)) {
            acc = (acc ^ (((16u + i) << 10u) | ((x - i) >> 9u)));
        } else {
            acc = (acc ^ ((x << 16u) * (acc | y)));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y >> 22u));
        acc = (acc ^ (acc + acc));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ (y * acc));
    }
    return acc;
}
