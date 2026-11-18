_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 32u) == 0u)) {
            acc = (acc ^ (1u | (i ^ acc)));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (acc + ((x - x) | (acc - acc))));
        acc = (acc ^ (acc * x));
    }
    return acc;
}
