_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x << 17u) + acc));
        if (((((x ^ y) ^ i) & 8192u) == 0u)) {
            acc = (acc ^ (y * 4294967295u));
            acc = (acc ^ 1u);
        } else {
            acc = (acc ^ ((x + (y | 16u)) >> 29u));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ ((acc * x) & acc));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ x);
    }
    return acc;
}
