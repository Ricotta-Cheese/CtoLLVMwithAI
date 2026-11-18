_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ (((x * x) - acc) & ((x - 16u) + (y + 16u))));
        acc = (acc ^ (((acc << 4u) & acc) ^ ((1u & acc) ^ (15u & x))));
    } else {
        acc = (acc ^ (1u << 0u));
    }
    acc = (acc ^ (((y ^ x) >> 26u) * ((y ^ acc) * (acc << 18u))));
    return acc;
}
