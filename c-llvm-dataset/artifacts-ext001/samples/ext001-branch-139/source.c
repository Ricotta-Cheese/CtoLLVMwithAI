_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ ((4294967295u * x) & (acc + y)));
        acc = (acc ^ (acc << 15u));
    } else {
        acc = (acc ^ ((x & y) >> 0u));
    }
    acc = (acc ^ 31u);
    return acc;
}
