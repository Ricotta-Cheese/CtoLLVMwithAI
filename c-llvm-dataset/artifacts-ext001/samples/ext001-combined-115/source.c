_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i << 25u) * (y - y)));
        acc = (acc ^ ((x | acc) + (3u * y)));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ ((acc * 7u) << 23u));
            acc = (acc ^ 0u);
        } else {
            acc = (acc ^ ((x * y) & 31u));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ ((16u + 3u) >> 11u));
    } else {
        acc = (acc ^ (16u >> 26u));
        acc = (acc ^ (((0u | 31u) & (acc & x)) * ((y >> 4u) * (y ^ y))));
    }
    return acc;
}
