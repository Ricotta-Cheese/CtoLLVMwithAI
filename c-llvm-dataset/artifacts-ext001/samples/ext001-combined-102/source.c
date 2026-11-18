_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((4294967295u | i) & 0u));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ (((acc - i) * (y << 5u)) >> 19u));
        } else {
            acc = (acc ^ ((i + acc) & (y >> 9u)));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ (x + (x + y)));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ (4213497447u & (acc + y)));
    }
    return acc;
}
