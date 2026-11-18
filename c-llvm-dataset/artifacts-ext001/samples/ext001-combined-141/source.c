_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y - 7u) >> 9u) - ((x & x) | (acc + x))));
        acc = (acc ^ acc);
        acc = (acc ^ ((15u << 14u) << 9u));
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (((acc >> 17u) ^ (x | acc)) ^ 16u));
            acc = (acc ^ ((15u * y) << 21u));
        } else {
            acc = (acc ^ (acc << 31u));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (x ^ 7u));
    } else {
        acc = (acc ^ ((y + 7u) | (acc << 16u)));
    }
    return acc;
}
