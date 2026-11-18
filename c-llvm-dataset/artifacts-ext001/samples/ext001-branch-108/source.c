_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (y << 10u));
        acc = (acc ^ (1u | acc));
    } else {
        acc = (acc ^ ((x << 0u) >> 16u));
        acc = (acc ^ (y ^ ((acc >> 22u) << 7u)));
    }
    acc = (acc ^ ((16u * acc) * (y | x)));
    return acc;
}
