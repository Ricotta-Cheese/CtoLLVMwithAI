_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc + 292491324u));
        acc = (acc ^ ((1208762271u ^ (acc & y)) << 19u));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ 3u);
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (x | i));
            acc = (acc ^ (x - acc));
        }
    }
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ (x + acc));
    } else {
        acc = (acc ^ ((y & x) * (x >> 13u)));
        acc = (acc ^ (x & x));
    }
    return acc;
}
