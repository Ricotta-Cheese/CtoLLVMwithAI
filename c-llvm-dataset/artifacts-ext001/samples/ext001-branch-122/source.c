_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (((7u | y) | (16u | y)) + (x + acc)));
    } else {
        acc = (acc ^ ((4294967295u << 15u) * (y - x)));
        acc = (acc ^ ((x >> 21u) & 4294967295u));
    }
    acc = (acc ^ ((acc | x) ^ acc));
    return acc;
}
