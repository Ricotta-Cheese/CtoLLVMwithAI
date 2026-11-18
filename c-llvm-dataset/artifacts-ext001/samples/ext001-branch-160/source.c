_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (((y >> 24u) - (y >> 10u)) - (x * x)));
    } else {
        acc = (acc ^ (((x & 0u) & (x + x)) << 31u));
        acc = (acc ^ (acc - acc));
    }
    acc = (acc ^ (acc + y));
    return acc;
}
