_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ ((y << 3u) + (i + x)));
        if (((((x ^ y) ^ i) & 16384u) == 0u)) {
            acc = (acc ^ (y >> 23u));
        } else {
            acc = (acc ^ (31u ^ x));
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ 1u);
        acc = (acc ^ (4294967295u & y));
    } else {
        acc = (acc ^ (x - x));
        acc = (acc ^ ((y + y) | (3u | 4294967295u)));
    }
    return acc;
}
