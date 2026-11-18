_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((7u - y) << 18u));
        acc = (acc ^ (((y * i) - (acc - i)) + ((i * i) * (3u | y))));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (i >> 31u));
        }
    }
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ (y >> 20u));
        acc = (acc ^ (((acc - 7u) + 4294967295u) & acc));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (((x << 28u) * (x + y)) & x));
    }
    return acc;
}
