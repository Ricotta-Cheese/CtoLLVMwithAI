_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y ^ 3958629267u) >> 9u) + ((y ^ y) * (x ^ acc))));
        acc = (acc ^ (((16u ^ x) >> 2u) ^ (7u - (i * x))));
    }
    return acc;
}
