_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((i & x) + (y + 15u)) << 18u));
        acc = (acc ^ (0u * 0u));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ ((31u >> 9u) - (y ^ 15u)));
            acc = (acc ^ ((i & i) >> 0u));
        } else {
            acc = (acc ^ 2u);
            acc = (acc ^ (((acc ^ i) << 23u) >> 8u));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (acc << 21u));
    } else {
        acc = (acc ^ (y << 1u));
        acc = (acc ^ ((x & (x >> 26u)) + ((x * 1311645669u) << 4u)));
    }
    return acc;
}
