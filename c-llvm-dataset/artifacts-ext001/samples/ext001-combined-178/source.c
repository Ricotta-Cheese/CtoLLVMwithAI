_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 67108864u) == 0u)) {
            acc = (acc ^ (((acc >> 17u) + (y ^ 3u)) & ((4294967295u * 31u) & (7u - i))));
            acc = (acc ^ ((acc ^ i) + (i << 14u)));
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (y | acc));
        acc = (acc ^ (1u * (16u >> 21u)));
    } else {
        acc = (acc ^ (((1u | x) - (x + y)) & ((x - x) + (y << 10u))));
    }
    return acc;
}
