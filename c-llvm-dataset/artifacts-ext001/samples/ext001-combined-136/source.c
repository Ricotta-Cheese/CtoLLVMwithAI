_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc ^ y) + (4294967295u - x)) << 18u));
        acc = (acc ^ (31u + x));
        acc = (acc ^ (y * (i >> 2u)));
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ y);
            acc = (acc ^ (((acc * y) - (x | i)) | ((y | x) << 31u)));
        } else {
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ (((x >> 5u) ^ (acc - x)) | ((acc * x) & (acc + 3u))));
    } else {
        acc = (acc ^ ((acc * 16u) + (acc - 2u)));
        acc = (acc ^ y);
    }
    return acc;
}
