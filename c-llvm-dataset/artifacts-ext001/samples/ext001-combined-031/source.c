_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i & 3485459517u) & (15u * acc)) - ((x >> 9u) >> 4u)));
        acc = (acc ^ acc);
        acc = (acc ^ (((0u & acc) & (0u - y)) * ((y - y) & (x * 2u))));
        if (((((x ^ y) ^ i) & 2048u) == 0u)) {
            acc = (acc ^ y);
        } else {
            acc = (acc ^ ((x << 22u) << 2u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ ((x + acc) * (y << 25u)));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (((3u & acc) | (x ^ y)) - ((7u << 11u) >> 24u)));
        acc = (acc ^ acc);
    }
    return acc;
}
