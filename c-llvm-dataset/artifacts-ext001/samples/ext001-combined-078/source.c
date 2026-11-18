_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (4294967295u | (y ^ (acc ^ 2654792112u))));
        acc = (acc ^ ((x << 15u) >> 26u));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ (x | (i << 15u)));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ ((y - x) + (acc | acc)));
        acc = (acc ^ (y << 30u));
    } else {
        acc = (acc ^ ((2u - acc) + (y * y)));
    }
    return acc;
}
