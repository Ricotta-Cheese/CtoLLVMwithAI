_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i << 13u));
        acc = (acc ^ (y - acc));
        acc = (acc ^ ((i * acc) | (y * i)));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ (acc ^ y));
            acc = (acc ^ (((y & x) << 11u) * ((y * acc) | (16u | 3u))));
        } else {
            acc = (acc ^ (x * x));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ (acc << 10u));
        acc = (acc ^ ((x ^ 4294967295u) & ((acc & y) << 17u)));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
