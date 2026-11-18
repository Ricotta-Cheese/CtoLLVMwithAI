_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (((y | x) ^ 31u) & ((acc << 5u) >> 19u)));
    } else {
        acc = (acc ^ ((y - y) >> 29u));
        acc = (acc ^ ((acc * acc) - (4294967295u & acc)));
    }
    acc = (acc ^ 7u);
    return acc;
}
