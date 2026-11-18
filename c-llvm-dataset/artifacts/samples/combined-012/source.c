_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i + i));
        acc = (acc ^ ((y * 4294967295u) << 24u));
        acc = (acc ^ y);
        if (((((x ^ y) ^ i) & 134217728u) == 0u)) {
            acc = (acc ^ (y - acc));
            acc = (acc ^ ((i & i) & (i | y)));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (y << 14u));
    } else {
        acc = (acc ^ ((acc ^ y) - (acc >> 14u)));
        acc = (acc ^ (x & (x ^ y)));
    }
    return acc;
}
