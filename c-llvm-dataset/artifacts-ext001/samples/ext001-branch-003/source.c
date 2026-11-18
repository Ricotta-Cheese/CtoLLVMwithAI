_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ 15u);
        acc = (acc ^ (((y - acc) ^ (acc & 15u)) ^ ((7u & 3u) | (y - 1u))));
    } else {
        acc = (acc ^ ((x >> 9u) << 10u));
    }
    acc = (acc ^ (3u * acc));
    return acc;
}
