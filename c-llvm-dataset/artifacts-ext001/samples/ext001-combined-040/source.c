_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (31u & acc));
        acc = (acc ^ (i << 29u));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ ((y << 5u) >> 15u));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ 31u);
    } else {
        acc = (acc ^ (0u - 7u));
        acc = (acc ^ (x ^ (x & acc)));
    }
    return acc;
}
