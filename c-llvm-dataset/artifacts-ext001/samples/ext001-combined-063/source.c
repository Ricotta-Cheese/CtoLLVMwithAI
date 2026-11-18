_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 3533242521u);
        acc = (acc ^ i);
        acc = (acc ^ (((acc - 7u) * (3u >> 14u)) * ((3u * i) & (acc * acc))));
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ (i * 0u));
            acc = (acc ^ x);
        } else {
            acc = (acc ^ 31u);
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ 7u);
        acc = (acc ^ (y * x));
    } else {
        acc = (acc ^ ((acc * x) | (acc ^ 374519310u)));
        acc = (acc ^ ((y + y) << 12u));
    }
    return acc;
}
