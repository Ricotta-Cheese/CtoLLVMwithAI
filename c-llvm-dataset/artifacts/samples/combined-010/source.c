_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y * acc));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ ((x ^ x) | y));
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ ((acc << 5u) * (y - y)));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (y | x));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (((2u - acc) + (acc ^ acc)) | 4294967295u));
    }
    return acc;
}
