_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (1u ^ acc));
        acc = (acc ^ (x >> 27u));
    } else {
        acc = (acc ^ (x >> 27u));
    }
    acc = (acc ^ (1u + (y & y)));
    return acc;
}
