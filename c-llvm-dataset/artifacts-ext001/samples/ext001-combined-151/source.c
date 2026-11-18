_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ 4294967295u);
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ ((4294967295u + acc) << 24u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ ((y * 7u) << 19u));
    } else {
        acc = (acc ^ (x * 7u));
        acc = (acc ^ (((y | x) * (0u >> 0u)) >> 30u));
    }
    return acc;
}
