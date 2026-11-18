_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (((y * acc) >> 21u) | ((x ^ x) * (x - 3u))));
    } else {
        acc = (acc ^ ((0u << 11u) - (acc + acc)));
        acc = (acc ^ 2u);
    }
    acc = (acc ^ (((x << 22u) ^ (acc - 3u)) * ((acc * 15u) * acc)));
    return acc;
}
