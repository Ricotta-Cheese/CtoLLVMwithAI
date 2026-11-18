_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (31u * acc));
        acc = (acc ^ (1489615894u >> 17u));
        if (((((x ^ y) ^ i) & 64u) == 0u)) {
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ y);
            acc = (acc ^ (((i << 8u) | (x << 16u)) | ((i * i) + (y - 15u))));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ x);
    } else {
        acc = (acc ^ ((x | (acc - x)) - (y + (y + 0u))));
    }
    return acc;
}
