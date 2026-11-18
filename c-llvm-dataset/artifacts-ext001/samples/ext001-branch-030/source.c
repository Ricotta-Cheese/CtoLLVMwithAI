_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (0u - y));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ ((acc >> 16u) + x));
    }
    acc = (acc ^ (((acc * acc) * (y * x)) * x));
    return acc;
}
