_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ ((acc << 12u) << 16u));
    } else {
        acc = (acc ^ (acc ^ y));
        acc = (acc ^ (((acc - acc) - acc) & ((4294967295u | 15u) ^ (2678459330u >> 5u))));
    }
    acc = (acc ^ ((acc ^ acc) ^ x));
    return acc;
}
