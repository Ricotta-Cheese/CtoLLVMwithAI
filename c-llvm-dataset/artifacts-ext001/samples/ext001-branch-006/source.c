_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (x | x));
    } else {
        acc = (acc ^ 4294967295u);
    }
    acc = (acc ^ ((4294967295u + acc) >> 17u));
    return acc;
}
