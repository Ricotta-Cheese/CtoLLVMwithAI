_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x << 30u) << 25u));
        if (((((x ^ y) ^ i) & 524288u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ (y >> 19u));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (acc >> 21u));
    } else {
        acc = (acc ^ (16u * (y >> 16u)));
        acc = (acc ^ ((15u + y) - (y | acc)));
    }
    return acc;
}
