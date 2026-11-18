_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((1u >> 13u) >> 7u) ^ ((7u << 1u) * 4294967295u)));
        acc = (acc ^ i);
        acc = (acc ^ (x >> 14u));
        if (((((x ^ y) ^ i) & 262144u) == 0u)) {
            acc = (acc ^ (acc >> 22u));
        } else {
            acc = (acc ^ ((1u + 227606253u) << 22u));
        }
    }
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (x * acc));
        acc = (acc ^ (y * y));
    } else {
        acc = (acc ^ (((x * 31u) >> 12u) - ((15u ^ y) & acc)));
        acc = (acc ^ (2u | ((7u & y) << 27u)));
    }
    return acc;
}
