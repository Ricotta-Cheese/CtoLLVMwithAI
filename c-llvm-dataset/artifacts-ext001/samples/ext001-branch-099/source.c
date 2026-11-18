_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (((x * acc) >> 10u) & ((x ^ 4294967295u) | (x - x))));
        acc = (acc ^ (((acc - acc) << 15u) & ((y | 31u) + (x >> 19u))));
    } else {
        acc = (acc ^ ((y + x) << 22u));
    }
    acc = (acc ^ (x << 29u));
    return acc;
}
