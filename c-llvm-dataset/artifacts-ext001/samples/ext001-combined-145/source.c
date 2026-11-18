_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ (x - (y << 3u)));
            acc = (acc ^ (((acc * y) << 26u) ^ (15u << 28u)));
        } else {
            acc = (acc ^ (i | x));
            acc = (acc ^ (((15u * y) >> 11u) - ((acc ^ 3u) + (1u >> 0u))));
        }
    }
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (((y | y) ^ (3u ^ 2u)) >> 16u));
    } else {
        acc = (acc ^ (((0u + y) + (16u & acc)) & (y + (y * x))));
    }
    return acc;
}
