_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (991230904u ^ 15u));
        acc = (acc ^ ((2194335298u << 29u) - (2u >> 14u)));
        if (((((x ^ y) ^ i) & 8388608u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ (((i & y) + (acc ^ acc)) | ((x - x) * (acc ^ i))));
        } else {
            acc = (acc ^ (i & ((0u | 3551374114u) | acc)));
            acc = (acc ^ (x >> 14u));
        }
    }
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (4294967295u | y));
    } else {
        acc = (acc ^ (((15u & acc) * acc) | ((x ^ acc) + (acc & acc))));
    }
    return acc;
}
