_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 31u);
        acc = (acc ^ (acc | x));
        acc = (acc ^ (((16u * i) | (acc >> 13u)) * ((7u + 7u) * (1u >> 24u))));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ (3u >> 30u));
            acc = (acc ^ (y | acc));
        } else {
            acc = (acc ^ (x << 4u));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ ((y + x) ^ (1u * y)));
    } else {
        acc = (acc ^ ((31u | 1u) | (x ^ 0u)));
    }
    return acc;
}
