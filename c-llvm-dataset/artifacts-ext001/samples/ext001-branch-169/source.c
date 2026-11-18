_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ ((acc + acc) - (4294967295u + acc)));
        acc = (acc ^ x);
    } else {
        acc = (acc ^ (4294967295u >> 15u));
    }
    acc = (acc ^ (((x ^ y) >> 29u) + ((acc ^ x) >> 15u)));
    return acc;
}
