_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x - y) * (4294967295u >> 14u)) << 20u));
        acc = (acc ^ (((x + acc) * (acc << 6u)) ^ ((4294967295u | 0u) | (x >> 29u))));
        acc = (acc ^ (((acc * y) & (2u ^ y)) << 26u));
        if (((((x ^ y) ^ i) & 16384u) == 0u)) {
            acc = (acc ^ ((i + 2u) & (acc * y)));
        } else {
            acc = (acc ^ ((i + y) ^ (472310085u ^ acc)));
            acc = (acc ^ (((x - y) * (x * x)) ^ ((x << 22u) | y)));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (acc << 25u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (acc ^ y));
    }
    return acc;
}
