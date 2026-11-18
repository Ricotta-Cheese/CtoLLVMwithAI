_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ ((acc ^ acc) | (889428125u & 31u)));
    } else {
        acc = (acc ^ (acc - y));
        acc = (acc ^ (1u & x));
    }
    acc = (acc ^ ((acc * 7u) ^ (1u - 15u)));
    return acc;
}
