_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (4294967295u >> 9u));
        acc = (acc ^ (x + 7u));
        acc = (acc ^ (((y - y) << 26u) | ((x - 1u) | (1u + acc))));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (x - (1u + (i >> 20u))));
        } else {
            acc = (acc ^ ((1456225996u * i) | (x - y)));
            acc = (acc ^ ((7u >> 17u) + x));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((x ^ acc) >> 20u));
        acc = (acc ^ (y | x));
    }
    return acc;
}
