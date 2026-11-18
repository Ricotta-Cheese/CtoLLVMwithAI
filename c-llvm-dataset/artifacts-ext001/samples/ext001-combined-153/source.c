_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 4294967295u);
        acc = (acc ^ 7u);
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ (((3u + y) - (i & 4294967295u)) ^ i));
        } else {
            acc = (acc ^ (acc >> 4u));
            acc = (acc ^ (x << 4u));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ (((x - y) & y) * y));
        acc = (acc ^ ((y | (y - x)) << 17u));
    } else {
        acc = (acc ^ (y ^ (15u | 3u)));
        acc = (acc ^ (y * 31u));
    }
    return acc;
}
