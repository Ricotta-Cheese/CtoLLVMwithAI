_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (1u * i));
        acc = (acc ^ (i & y));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ ((i ^ acc) & y));
            acc = (acc ^ ((0u >> 26u) - i));
        } else {
            acc = (acc ^ ((i << 23u) | (x + x)));
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (acc << 23u));
    }
    return acc;
}
