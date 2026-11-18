_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (acc * 2u));
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (acc << 5u));
        acc = (acc ^ (7u << 25u));
    }
    acc = (acc ^ ((x ^ acc) << 23u));
    return acc;
}
