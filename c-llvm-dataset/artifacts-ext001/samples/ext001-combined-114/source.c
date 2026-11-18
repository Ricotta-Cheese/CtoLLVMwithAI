_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i * i) << 9u));
        acc = (acc ^ ((y << 19u) | (acc + 31u)));
        acc = (acc ^ ((x & acc) & (y >> 19u)));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ ((acc - 1907762766u) ^ (y - i)));
        } else {
            acc = (acc ^ (x - x));
            acc = (acc ^ 2u);
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (y * y));
        acc = (acc ^ 1u);
    } else {
        acc = (acc ^ ((y << 22u) - y));
        acc = (acc ^ ((x & acc) >> 12u));
    }
    return acc;
}
