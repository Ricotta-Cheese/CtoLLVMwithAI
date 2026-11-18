_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (3u * acc));
        acc = (acc ^ (x * ((i | 31u) & (y + i))));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ (x & 7u));
        } else {
            acc = (acc ^ i);
            acc = (acc ^ ((acc * i) << 6u));
        }
    }
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (y & x));
    } else {
        acc = (acc ^ (x & x));
    }
    return acc;
}
