_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y ^ x));
        acc = (acc ^ (i * y));
        acc = (acc ^ ((i ^ i) >> 4u));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (acc + (i | acc)));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ ((15u * y) >> 23u));
        acc = (acc ^ ((y >> 15u) | (acc >> 5u)));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ ((acc >> 0u) ^ (1u + 31u)));
    }
    return acc;
}
