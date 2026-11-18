_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (2u - 1u));
    } else {
        acc = (acc ^ ((x << 10u) ^ (acc + acc)));
        acc = (acc ^ (y - y));
    }
    acc = (acc ^ ((1u + 4294967295u) & x));
    return acc;
}
