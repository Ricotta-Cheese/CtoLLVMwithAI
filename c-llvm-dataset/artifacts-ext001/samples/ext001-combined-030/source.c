_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i | x));
        acc = (acc ^ (4294967295u - (y | acc)));
        acc = (acc ^ ((y * acc) * (1u ^ acc)));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ (acc + 0u));
            acc = (acc ^ ((y >> 0u) >> 3u));
        } else {
            acc = (acc ^ (acc + acc));
            acc = (acc ^ ((acc | 3779157238u) - ((acc * acc) | (i << 21u))));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (16u >> 8u));
    } else {
        acc = (acc ^ (((y ^ y) | (16u + y)) ^ ((1u << 19u) | (acc * x))));
        acc = (acc ^ (((7u | x) & (y + acc)) << 1u));
    }
    return acc;
}
