_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y + acc) - (acc & x)));
        acc = (acc ^ (i + x));
        acc = (acc ^ ((x * x) ^ (i * x)));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ (acc << 21u));
            acc = (acc ^ (0u + acc));
        } else {
            acc = (acc ^ (y >> 19u));
            acc = (acc ^ (i + i));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (((15u << 24u) | (y >> 26u)) << 20u));
    } else {
        acc = (acc ^ ((x << 20u) ^ (acc * 4294967295u)));
        acc = (acc ^ (((y - x) >> 30u) + (1u * (y | acc))));
    }
    return acc;
}
