_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc * x) + (3u * acc)));
        acc = (acc ^ ((15u << 22u) - (x | y)));
        acc = (acc ^ 4294967295u);
        if (((((x ^ y) ^ i) & 134217728u) == 0u)) {
            acc = (acc ^ ((i * y) << 5u));
        } else {
            acc = (acc ^ (((acc >> 19u) >> 21u) * i));
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (((acc & 7u) >> 28u) ^ ((y >> 2u) + (3u >> 3u))));
    }
    return acc;
}
