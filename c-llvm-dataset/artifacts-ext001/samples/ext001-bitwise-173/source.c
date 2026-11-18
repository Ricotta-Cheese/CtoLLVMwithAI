_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((x & x) >> 27u) << 22u));
    acc = (acc ^ (x & (x ^ (0u | x))));
    acc = (acc ^ 3275116092u);
    acc = (acc ^ ((acc << 15u) & (y ^ y)));
    return acc;
}
