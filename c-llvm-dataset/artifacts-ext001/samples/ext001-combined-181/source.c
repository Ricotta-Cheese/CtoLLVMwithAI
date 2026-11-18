_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x + ((i << 26u) + y)));
        acc = (acc ^ y);
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ (((acc ^ acc) + (3u ^ x)) ^ ((i + acc) | (x + 7u))));
        } else {
            acc = (acc ^ acc);
            acc = (acc ^ (y << 7u));
        }
    }
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (y << 3u));
    } else {
        acc = (acc ^ ((y << 14u) << 3u));
    }
    return acc;
}
