_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y - x) << 22u));
        acc = (acc ^ ((2u << 13u) | ((acc * x) - (x | y))));
        acc = (acc ^ (y << 1u));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ (y << 25u));
        } else {
            acc = (acc ^ (((702043760u + i) + (2591555801u - 15u)) * (i ^ (x * acc))));
        }
    }
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ ((1u & x) << 26u));
    } else {
        acc = (acc ^ (acc | ((16u | 1u) & (3u ^ 15u))));
        acc = (acc ^ (((y | x) * (x * 31u)) | (4294967295u & (y * acc))));
    }
    return acc;
}
