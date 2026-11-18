_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (y & 1u));
    } else {
        acc = (acc ^ ((y + (y << 26u)) >> 0u));
        acc = (acc ^ (((x + y) - (x * x)) - (0u ^ (x << 30u))));
    }
    acc = (acc ^ ((y << 3u) - (y ^ (x ^ 15u))));
    return acc;
}
