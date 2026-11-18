_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((31u >> 4u) ^ 2u) & ((y - i) ^ (y & x))));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ ((y << 14u) - (y - (x - x))));
            acc = (acc ^ ((y >> 7u) >> 5u));
        } else {
            acc = (acc ^ (acc - ((x * x) ^ acc)));
            acc = (acc ^ ((x + 31u) << 8u));
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ 3767194865u);
    } else {
        acc = (acc ^ (487515775u - (x ^ acc)));
    }
    return acc;
}
