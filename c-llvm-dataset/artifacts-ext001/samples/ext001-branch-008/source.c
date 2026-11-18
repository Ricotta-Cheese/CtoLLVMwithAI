_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ ((16u * 1u) | (1u & 1u)));
        acc = (acc ^ ((acc | y) ^ ((1u & y) * (x + 31u))));
    } else {
        acc = (acc ^ (x * acc));
        acc = (acc ^ (((y - 31u) & acc) & (7u * (y - x))));
    }
    acc = (acc ^ (x + acc));
    return acc;
}
