_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x & y) << 25u) - ((i >> 3u) & (16u - 16u))));
        acc = (acc ^ (16u - acc));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (3831933795u ^ x));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ (4294967295u + x));
    } else {
        acc = (acc ^ ((x - 16u) | acc));
    }
    return acc;
}
