_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ y);
        acc = (acc ^ (i >> 14u));
        acc = (acc ^ (acc ^ i));
        if (((((x ^ y) ^ i) & 32768u) == 0u)) {
            acc = (acc ^ ((x - y) * (acc ^ x)));
            acc = (acc ^ ((4294967295u << 29u) ^ (7u | x)));
        } else {
            acc = (acc ^ (acc - y));
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ (x * (1u * y)));
    } else {
        acc = (acc ^ ((x & acc) & y));
    }
    return acc;
}
