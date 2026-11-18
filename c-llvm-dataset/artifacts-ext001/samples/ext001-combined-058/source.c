_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 16u);
        acc = (acc ^ (acc & x));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ y);
            acc = (acc ^ ((2u + 16u) | ((x << 2u) * acc)));
        } else {
            acc = (acc ^ ((x << 28u) >> 2u));
            acc = (acc ^ (x << 31u));
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (y ^ 2u));
        acc = (acc ^ (2395423523u << 5u));
    }
    return acc;
}
