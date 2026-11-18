_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i | y) * (x - i)));
        acc = (acc ^ x);
        acc = (acc ^ (((y & acc) >> 12u) * ((acc - x) - (i >> 8u))));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ (i & y));
            acc = (acc ^ (3u << 27u));
        } else {
            acc = (acc ^ ((acc | y) >> 9u));
            acc = (acc ^ 7u);
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ (y + (4294967295u | x)));
    } else {
        acc = (acc ^ (((x - x) + (31u | x)) - acc));
    }
    return acc;
}
