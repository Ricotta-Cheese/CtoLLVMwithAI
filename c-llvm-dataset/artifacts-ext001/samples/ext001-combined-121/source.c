_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i << 6u) * (i & y)));
        acc = (acc ^ acc);
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ ((y ^ x) | (4294967295u * i)));
        } else {
            acc = (acc ^ x);
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 2048u) == 0u)) {
        acc = (acc ^ ((1u - 0u) + (y ^ y)));
    } else {
        acc = (acc ^ (x | x));
    }
    return acc;
}
