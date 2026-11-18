_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((i + (31u | i)) | ((x << 6u) - (x + acc))));
        acc = (acc ^ (4294967295u << 29u));
        acc = (acc ^ x);
        if (((((x ^ y) ^ i) & 1073741824u) == 0u)) {
            acc = (acc ^ (x * i));
        } else {
            acc = (acc ^ (i ^ 31u));
            acc = (acc ^ (15u >> 21u));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (y & x));
    } else {
        acc = (acc ^ ((acc ^ x) ^ (x + 3u)));
    }
    return acc;
}
