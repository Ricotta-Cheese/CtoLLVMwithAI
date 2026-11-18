_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x * (31u & (x ^ 3u))));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ ((y + x) ^ y));
        } else {
            acc = (acc ^ 0u);
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (x ^ y));
        acc = (acc ^ (0u & acc));
    } else {
        acc = (acc ^ (acc ^ 7u));
    }
    return acc;
}
