_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((acc >> 21u) ^ (acc << 16u)) + (x << 10u)));
        acc = (acc ^ (((i & x) * x) | ((acc << 15u) * (x * acc))));
        acc = (acc ^ ((acc >> 30u) * ((x << 4u) ^ (acc * 1u))));
        if (((((x ^ y) ^ i) & 2097152u) == 0u)) {
            acc = (acc ^ x);
            acc = (acc ^ (y >> 11u));
        } else {
            acc = (acc ^ (7u * 7u));
            acc = (acc ^ (((i ^ 4294967295u) & (i ^ 1u)) << 16u));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((acc << 22u) >> 10u));
        acc = (acc ^ (3031295964u ^ (4294967295u >> 24u)));
    } else {
        acc = (acc ^ 3u);
        acc = (acc ^ (((x ^ y) * (acc * y)) | x));
    }
    return acc;
}
