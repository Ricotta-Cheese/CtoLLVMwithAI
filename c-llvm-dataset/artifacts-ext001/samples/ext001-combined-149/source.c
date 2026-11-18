_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y << 9u));
        acc = (acc ^ (x ^ ((x & 3u) << 30u)));
        if (((((x ^ y) ^ i) & 1u) == 0u)) {
            acc = (acc ^ (0u >> 10u));
            acc = (acc ^ (((y + x) & (i * y)) - ((y << 17u) >> 11u)));
        } else {
            acc = (acc ^ 16u);
            acc = (acc ^ (((15u | 16u) + (acc + acc)) | ((15u + i) ^ (y - acc))));
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (y | acc));
    } else {
        acc = (acc ^ ((7u << 9u) * (1u * 903024504u)));
        acc = (acc ^ y);
    }
    return acc;
}
