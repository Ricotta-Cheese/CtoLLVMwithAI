_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (2u & (y ^ acc)));
    } else {
        acc = (acc ^ (((1u * 1u) << 2u) * (acc & x)));
        acc = (acc ^ (((x - 3133190460u) >> 2u) << 7u));
    }
    acc = (acc ^ (1u * ((acc * y) * (acc - acc))));
    return acc;
}
