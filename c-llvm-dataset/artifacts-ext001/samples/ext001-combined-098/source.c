_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y << 6u) * (acc - x)));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ (((y & x) - 4294967295u) * ((acc + x) | (i - x))));
            acc = (acc ^ (((y << 19u) ^ (2u >> 23u)) * ((x << 28u) << 30u)));
        } else {
            acc = (acc ^ ((x ^ (acc >> 15u)) >> 14u));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ ((x * y) + (x - y)));
        acc = (acc ^ (acc * y));
    } else {
        acc = (acc ^ ((x & 0u) >> 30u));
        acc = (acc ^ ((acc & acc) + (acc & x)));
    }
    return acc;
}
