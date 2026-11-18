_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (((x & y) * (acc + 4294967295u)) << 5u));
        acc = (acc ^ (16u + x));
    } else {
        acc = (acc ^ 16u);
        acc = (acc ^ (4294967295u & 31u));
    }
    acc = (acc ^ (y | y));
    return acc;
}
