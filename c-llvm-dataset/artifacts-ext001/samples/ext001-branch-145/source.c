_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ 1u);
    }
    acc = (acc ^ ((acc + acc) + (acc ^ y)));
    return acc;
}
