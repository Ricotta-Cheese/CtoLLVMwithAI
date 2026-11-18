_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (((acc * x) ^ (x * y)) + ((2u >> 18u) ^ (x | y))));
        acc = (acc ^ (((x | acc) ^ x) ^ x));
    } else {
        acc = (acc ^ (x - y));
        acc = (acc ^ (2u << 19u));
    }
    acc = (acc ^ (y ^ 2u));
    return acc;
}
