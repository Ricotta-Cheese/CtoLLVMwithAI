_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((acc & 0u) & (i + acc)));
        acc = (acc ^ (4294967295u & 2009900945u));
        acc = (acc ^ (4095933463u * (i * x)));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ ((x << 4u) - 4294967295u));
        } else {
            acc = (acc ^ (i >> 10u));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (x & 1u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ ((x ^ x) << 25u));
    }
    return acc;
}
