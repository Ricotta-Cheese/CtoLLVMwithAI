_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (0u | acc));
        acc = (acc ^ (i >> 12u));
        if (((((x ^ y) ^ i) & 4194304u) == 0u)) {
            acc = (acc ^ (0u ^ 7u));
        } else {
            acc = (acc ^ (i - i));
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (((4294967295u - x) >> 26u) & y));
    } else {
        acc = (acc ^ 3u);
    }
    return acc;
}
