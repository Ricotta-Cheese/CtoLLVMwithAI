_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (x * (y - 4294967295u)));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ ((1u >> 22u) << 29u));
    }
    acc = (acc ^ (acc ^ ((acc & x) - (y + x))));
    return acc;
}
