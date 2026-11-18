_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (((y - y) + x) * (x | (y + x))));
    } else {
        acc = (acc ^ (acc | 7u));
    }
    acc = (acc ^ (x >> 27u));
    return acc;
}
