_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (acc & 7u));
        acc = (acc ^ ((x + 31u) << 10u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (((y ^ y) >> 18u) - ((acc * x) ^ (acc & 7u))));
    }
    acc = (acc ^ ((0u - 15u) >> 26u));
    return acc;
}
