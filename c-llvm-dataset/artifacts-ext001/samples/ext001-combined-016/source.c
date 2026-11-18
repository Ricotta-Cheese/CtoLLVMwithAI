_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (((y >> 19u) << 25u) ^ x));
        } else {
            acc = (acc ^ ((i + i) | (x ^ x)));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (((16u ^ x) + (x | y)) << 22u));
        acc = (acc ^ ((y - 1u) ^ (y + 2u)));
    } else {
        acc = (acc ^ y);
    }
    return acc;
}
