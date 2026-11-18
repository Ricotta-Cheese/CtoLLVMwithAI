_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ ((x | y) * (y * 7u)));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ (16u & 4294967295u));
    }
    acc = (acc ^ (acc & (x * acc)));
    return acc;
}
