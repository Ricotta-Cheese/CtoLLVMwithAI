_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (4294967295u << 31u));
        acc = (acc ^ (0u * acc));
        acc = (acc ^ 7u);
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (((i * 2u) ^ (y >> 27u)) & y));
            acc = (acc ^ (((x << 3u) << 6u) & ((i & acc) - (x << 15u))));
        } else {
            acc = (acc ^ ((acc - 3u) & 31u));
            acc = (acc ^ (y ^ 3u));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ ((y + y) - (acc << 25u)));
    } else {
        acc = (acc ^ (((acc >> 31u) - (15u ^ 31u)) * x));
    }
    return acc;
}
