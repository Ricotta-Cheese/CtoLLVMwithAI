_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (4294967295u - y));
        acc = (acc ^ (((15u * i) + (x | x)) - 16u));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ (i * x));
            acc = (acc ^ (((y << 1u) - 722993374u) - 4294967295u));
        } else {
            acc = (acc ^ (y >> 10u));
            acc = (acc ^ (x * 0u));
        }
    }
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ ((0u ^ 3u) ^ (acc + 2u)));
        acc = (acc ^ (((2690257908u | x) << 4u) - x));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
