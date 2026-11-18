_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y * (15u ^ x)) << 4u));
        acc = (acc ^ y);
        acc = (acc ^ (acc + x));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ ((y ^ y) & (x * acc)));
        } else {
            acc = (acc ^ (acc + (i << 8u)));
            acc = (acc ^ ((1522758240u ^ (x << 31u)) * acc));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((y & 4294967295u) & acc));
        acc = (acc ^ ((3u + 3u) << 1u));
    } else {
        acc = (acc ^ ((y * 7u) | (y + y)));
    }
    return acc;
}
