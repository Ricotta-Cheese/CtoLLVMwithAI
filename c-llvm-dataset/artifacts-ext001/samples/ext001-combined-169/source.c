_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (7u >> 10u));
        acc = (acc ^ (((y ^ i) ^ (i >> 3u)) + (y >> 31u)));
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ 4294967295u);
            acc = (acc ^ (x & acc));
        } else {
            acc = (acc ^ (((x << 19u) + (acc ^ acc)) & ((i ^ x) * (acc * i))));
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ 3u);
        acc = (acc ^ ((1u + 4294967295u) + (x << 10u)));
    } else {
        acc = (acc ^ (y ^ acc));
    }
    return acc;
}
