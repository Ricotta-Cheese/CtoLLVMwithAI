_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ x);
    } else {
        acc = (acc ^ (x << 0u));
        acc = (acc ^ ((x >> 3u) - (16u | x)));
    }
    acc = (acc ^ ((31u - acc) * (1u + x)));
    return acc;
}
