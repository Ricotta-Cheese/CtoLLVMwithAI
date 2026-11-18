_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ (((acc ^ acc) >> 23u) & ((x - y) | (acc | x))));
        acc = (acc ^ (acc >> 22u));
    } else {
        acc = (acc ^ ((x - (y + acc)) << 28u));
        acc = (acc ^ ((y * y) & acc));
    }
    acc = (acc ^ y);
    return acc;
}
