_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc << 6u));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (x << 24u));
        } else {
            acc = (acc ^ (0u << 1u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y + 15u));
    } else {
        acc = (acc ^ 3u);
        acc = (acc ^ (x + y));
    }
    return acc;
}
