_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ ((acc - 3u) * (y * 3075408795u)));
    } else {
        acc = (acc ^ ((x + 7u) + (0u | 1u)));
        acc = (acc ^ (((15u | x) << 20u) | (y + 0u)));
    }
    acc = (acc ^ ((7u | acc) << 6u));
    return acc;
}
