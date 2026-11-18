_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (((acc | acc) * (acc ^ y)) & ((acc + x) | acc)));
    }
    acc = (acc ^ (144330426u - ((3u & acc) ^ (x | 15u))));
    return acc;
}
