_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (x ^ ((acc ^ y) ^ (2u << 31u))));
    acc = (acc ^ (y << 5u));
    acc = (acc ^ (((y | acc) << 20u) << 11u));
    return acc;
}
