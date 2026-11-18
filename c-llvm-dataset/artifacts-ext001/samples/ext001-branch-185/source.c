_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((16u | y) >> 18u));
        acc = (acc ^ ((16u << 12u) ^ (acc ^ x)));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (y & x));
    return acc;
}
