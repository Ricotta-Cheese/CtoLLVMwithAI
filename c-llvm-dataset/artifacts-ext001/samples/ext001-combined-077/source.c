_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (acc - i));
        acc = (acc ^ (acc + (acc - i)));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ (acc & acc));
            acc = (acc ^ (15u + i));
        } else {
            acc = (acc ^ (x - acc));
            acc = (acc ^ ((y | x) | (31u + x)));
        }
    }
    if ((((x ^ y) & 64u) == 0u)) {
        acc = (acc ^ (x - acc));
    } else {
        acc = (acc ^ ((x + y) | (y | acc)));
        acc = (acc ^ (y + x));
    }
    return acc;
}
