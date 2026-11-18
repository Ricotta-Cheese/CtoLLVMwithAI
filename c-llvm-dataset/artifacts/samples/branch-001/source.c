_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ ((y << 30u) + x));
    } else {
        acc = (acc ^ (x ^ y));
        acc = (acc ^ (((acc - 3u) & (y * acc)) * x));
    }
    acc = (acc ^ ((x | y) & (x * y)));
    return acc;
}
