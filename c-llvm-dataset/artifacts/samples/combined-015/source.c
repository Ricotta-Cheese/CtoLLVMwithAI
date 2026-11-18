_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x - (acc + 15u)));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (0u & i));
            acc = (acc ^ acc);
        } else {
            acc = (acc ^ y);
        }
    }
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ ((y << 22u) - x));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((acc ^ acc) * (y | x)));
        acc = (acc ^ (((acc + y) ^ (y & x)) | x));
    }
    return acc;
}
