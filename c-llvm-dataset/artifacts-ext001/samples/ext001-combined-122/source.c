_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((1u - 0u) | (16u ^ x)) << 0u));
        acc = (acc ^ (15u >> 21u));
        if (((((x ^ y) ^ i) & 1073741824u) == 0u)) {
            acc = (acc ^ (y >> 30u));
            acc = (acc ^ (((15u ^ acc) - 31u) - (x << 9u)));
        } else {
            acc = (acc ^ (x >> 25u));
            acc = (acc ^ (((i + x) - acc) ^ (3u ^ (x ^ x))));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (15u * 1u));
        acc = (acc ^ (x * x));
    } else {
        acc = (acc ^ (acc << 3u));
    }
    return acc;
}
