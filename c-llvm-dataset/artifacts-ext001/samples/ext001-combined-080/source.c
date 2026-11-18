_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y ^ y));
        acc = (acc ^ ((y * x) * (acc * i)));
        acc = (acc ^ (3u * 31u));
        if (((((x ^ y) ^ i) & 1024u) == 0u)) {
            acc = (acc ^ (i ^ y));
        } else {
            acc = (acc ^ (((acc << 30u) - (acc << 13u)) >> 29u));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ (x - acc));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (((acc | 1556820182u) | (x & acc)) << 12u));
        acc = (acc ^ (y * 4294967295u));
    }
    return acc;
}
