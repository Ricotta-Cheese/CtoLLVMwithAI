_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i | x));
        acc = (acc ^ ((y + i) - y));
        acc = (acc ^ ((i * acc) >> 0u));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ (((i - x) + (i + acc)) - 4294967295u));
        } else {
            acc = (acc ^ x);
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (y * x));
    } else {
        acc = (acc ^ ((x + y) & (x * x)));
    }
    return acc;
}
