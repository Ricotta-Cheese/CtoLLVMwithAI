_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((0u + x) | (y * acc)) * (x - (acc | y))));
        acc = (acc ^ (y * acc));
        acc = (acc ^ ((x << 19u) + (i ^ i)));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (((i * x) >> 27u) + 7u));
            acc = (acc ^ ((x | acc) * (x | x)));
        } else {
            acc = (acc ^ (i * acc));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (15u + y));
    } else {
        acc = (acc ^ (y >> 14u));
    }
    return acc;
}
