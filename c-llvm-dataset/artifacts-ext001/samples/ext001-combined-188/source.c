_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (((x * acc) >> 29u) ^ 7u));
        acc = (acc ^ (x + y));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ (i & y));
            acc = (acc ^ (acc - i));
        } else {
            acc = (acc ^ (acc * x));
        }
    }
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ (x ^ y));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (((acc * x) - (y ^ acc)) << 9u));
        acc = (acc ^ acc);
    }
    return acc;
}
