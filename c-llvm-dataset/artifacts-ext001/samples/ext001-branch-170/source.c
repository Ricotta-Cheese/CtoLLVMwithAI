_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (((y - x) * (x - x)) ^ y));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (31u << 18u));
    return acc;
}
