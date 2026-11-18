_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc >> 9u) >> 31u));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ (acc - i));
            acc = (acc ^ (i + 2u));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (7u - x));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
