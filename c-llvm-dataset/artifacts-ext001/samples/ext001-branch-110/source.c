_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ (((3u ^ 2u) >> 24u) | acc));
        acc = (acc ^ (acc + y));
    } else {
        acc = (acc ^ (1u & (x >> 0u)));
        acc = (acc ^ (x - 15u));
    }
    acc = (acc ^ ((y * acc) - (x + y)));
    return acc;
}
