_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (acc >> 18u));
        acc = (acc ^ (acc >> 14u));
    } else {
        acc = (acc ^ ((16u & (acc + acc)) - x));
        acc = (acc ^ x);
    }
    acc = (acc ^ (acc + 745058835u));
    return acc;
}
