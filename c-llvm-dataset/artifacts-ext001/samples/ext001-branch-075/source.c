_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (31u & (acc - y)));
        acc = (acc ^ (y | 15u));
    } else {
        acc = (acc ^ (x << 27u));
    }
    acc = (acc ^ (x ^ acc));
    return acc;
}
