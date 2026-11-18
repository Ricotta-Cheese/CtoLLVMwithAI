_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ ((y + 16u) | (y | acc)));
        acc = (acc ^ (acc << 16u));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ y);
    }
    acc = (acc ^ x);
    return acc;
}
