_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i & i));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ (0u & 1u));
            acc = (acc ^ ((acc - y) * (y + i)));
        } else {
            acc = (acc ^ (((15u | 3u) << 9u) | ((i | x) * acc)));
            acc = (acc ^ 16u);
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ 7u);
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (((x ^ y) | (y + y)) >> 0u));
    }
    return acc;
}
