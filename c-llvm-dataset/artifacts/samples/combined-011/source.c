_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i - acc));
        acc = (acc ^ i);
        acc = (acc ^ ((x | (i - y)) - (y ^ (3u & 2666385321u))));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ ((x - acc) & (acc << 4u)));
            acc = (acc ^ ((i << 14u) | (i | y)));
        } else {
            acc = (acc ^ (((acc << 12u) * (2u << 12u)) | (980611275u - (y ^ y))));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (x << 0u));
        acc = (acc ^ ((acc & 337358672u) + (0u | 2u)));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
