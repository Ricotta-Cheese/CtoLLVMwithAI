_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (x + x));
    } else {
        acc = (acc ^ (16u + ((1900424106u + acc) ^ (acc + y))));
        acc = (acc ^ (x | x));
    }
    acc = (acc ^ ((1u - x) & (y ^ x)));
    return acc;
}
