_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (3u >> 12u));
        acc = (acc ^ (0u - 3u));
    } else {
        acc = (acc ^ (((acc ^ y) * (4294967295u & 4294967295u)) >> 23u));
        acc = (acc ^ (acc - y));
    }
    acc = (acc ^ (((31u | 4294967295u) - (acc >> 20u)) & ((acc | y) | 16u)));
    return acc;
}
