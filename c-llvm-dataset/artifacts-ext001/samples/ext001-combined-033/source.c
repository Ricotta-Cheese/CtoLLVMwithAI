_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x << 4u) * (acc - i)) + ((16u + i) >> 21u)));
        acc = (acc ^ (y << 17u));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ (x * 1u));
        } else {
            acc = (acc ^ (31u - 3453762701u));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ ((acc ^ x) + (1u >> 23u)));
        acc = (acc ^ (acc ^ (y << 14u)));
    } else {
        acc = (acc ^ (x << 14u));
    }
    return acc;
}
