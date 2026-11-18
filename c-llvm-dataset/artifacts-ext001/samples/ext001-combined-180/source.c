_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y << 8u) - 4294967295u));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 8u) == 0u)) {
            acc = (acc ^ (((i ^ acc) * (i - i)) >> 14u));
        } else {
            acc = (acc ^ ((i & (i + 2712142275u)) * ((i & acc) >> 13u)));
            acc = (acc ^ 4294967295u);
        }
    }
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ ((x & acc) * (acc << 31u)));
    } else {
        acc = (acc ^ (y - acc));
        acc = (acc ^ (y - (y >> 23u)));
    }
    return acc;
}
