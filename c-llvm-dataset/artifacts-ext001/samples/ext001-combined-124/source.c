_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc | y));
        acc = (acc ^ ((0u ^ i) | (i * acc)));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (y * (acc ^ x)));
            acc = (acc ^ (y >> 18u));
        } else {
            acc = (acc ^ ((y & 2584529487u) + (i ^ i)));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (acc * y));
    } else {
        acc = (acc ^ y);
    }
    return acc;
}
