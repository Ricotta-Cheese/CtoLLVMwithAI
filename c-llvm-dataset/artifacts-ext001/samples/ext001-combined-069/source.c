_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc + acc));
        acc = (acc ^ ((y << 6u) + ((4294967295u | 31u) << 0u)));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ ((i * 31u) + (3u & i)));
            acc = (acc ^ ((0u & x) & (i >> 26u)));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ ((y | (x ^ 0u)) >> 31u));
    } else {
        acc = (acc ^ ((x ^ acc) << 1u));
    }
    return acc;
}
