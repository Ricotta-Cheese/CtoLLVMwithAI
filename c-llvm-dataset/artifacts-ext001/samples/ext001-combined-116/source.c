_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 4294967295u);
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ (y >> 8u));
        } else {
            acc = (acc ^ (2u * y));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (((x - x) << 16u) + ((y + 2u) << 21u)));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ x);
        acc = (acc ^ (15u * x));
    }
    return acc;
}
