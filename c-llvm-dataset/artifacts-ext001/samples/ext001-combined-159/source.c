_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc - acc) + y));
        acc = (acc ^ (i * y));
        if (((((x ^ y) ^ i) & 134217728u) == 0u)) {
            acc = (acc ^ (y - 4294967295u));
            acc = (acc ^ (734859673u ^ acc));
        } else {
            acc = (acc ^ ((acc - x) + (y + y)));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ ((x << 6u) * (acc & acc)));
        acc = (acc ^ (((2u << 23u) * (4294967295u >> 25u)) & ((x >> 10u) | (acc | 15u))));
    } else {
        acc = (acc ^ (acc | y));
    }
    return acc;
}
