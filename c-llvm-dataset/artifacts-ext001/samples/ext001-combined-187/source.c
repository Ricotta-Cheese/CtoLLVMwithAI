_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i | x));
        acc = (acc ^ (x * i));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ ((i << 5u) >> 26u));
            acc = (acc ^ (((x | i) * (i ^ 7u)) >> 17u));
        } else {
            acc = (acc ^ (((acc * 31u) + (acc & 4294967295u)) | ((i >> 4u) - (acc >> 21u))));
            acc = (acc ^ (acc << 31u));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ ((x - x) ^ (x * 4294967295u)));
    } else {
        acc = (acc ^ acc);
    }
    return acc;
}
