_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 3382908137u);
        acc = (acc ^ ((x * 2u) | (y >> 25u)));
        acc = (acc ^ (3u & y));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ (i * 15u));
            acc = (acc ^ (y | i));
        } else {
            acc = (acc ^ ((x & x) & (i * acc)));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (4294967295u ^ acc));
        acc = (acc ^ (y << 15u));
    } else {
        acc = (acc ^ (x & acc));
    }
    return acc;
}
