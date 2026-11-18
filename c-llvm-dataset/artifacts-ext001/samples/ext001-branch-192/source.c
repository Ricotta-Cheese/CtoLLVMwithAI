_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ ((4294967295u >> 30u) - (acc >> 31u)));
        acc = (acc ^ (15u << 2u));
    } else {
        acc = (acc ^ ((31u + acc) - (acc * y)));
        acc = (acc ^ (y * y));
    }
    acc = (acc ^ (acc + 2u));
    return acc;
}
