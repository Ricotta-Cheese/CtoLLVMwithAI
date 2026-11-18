_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y >> 13u) * i) << 8u));
        if (((((x ^ y) ^ i) & 8192u) == 0u)) {
            acc = (acc ^ (((acc + i) + (x & i)) & ((x >> 4u) + (x & i))));
        } else {
            acc = (acc ^ (((acc * 2u) | (x & 16u)) + ((4294967295u - 1u) * x)));
            acc = (acc ^ (acc >> 17u));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (0u ^ acc));
    } else {
        acc = (acc ^ ((7u + acc) + (x & 15u)));
        acc = (acc ^ (4003548545u ^ (x & (x & acc))));
    }
    return acc;
}
