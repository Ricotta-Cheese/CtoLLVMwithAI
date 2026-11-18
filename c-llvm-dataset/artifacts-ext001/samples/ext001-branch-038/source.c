_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (y - x));
    } else {
        acc = (acc ^ (y + y));
    }
    acc = (acc ^ y);
    return acc;
}
