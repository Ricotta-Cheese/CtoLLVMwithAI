_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((2u & y) & (x + x)));
        acc = (acc ^ ((16u - 141165707u) & (y - y)));
        acc = (acc ^ (((x | acc) - (y * y)) << 28u));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ ((15u >> 0u) - (y * i)));
        } else {
            acc = (acc ^ (((x - x) << 29u) << 6u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (acc << 17u));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ (((acc >> 17u) << 6u) ^ ((16u ^ acc) >> 8u)));
    }
    return acc;
}
