_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((31u | acc) << 29u));
        acc = (acc ^ (((i >> 25u) * (i >> 9u)) & ((y * 0u) - (y >> 4u))));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 2048u) == 0u)) {
            acc = (acc ^ (4294967295u * y));
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ (x >> 9u));
    } else {
        acc = (acc ^ (x << 22u));
        acc = (acc ^ (0u - y));
    }
    return acc;
}
