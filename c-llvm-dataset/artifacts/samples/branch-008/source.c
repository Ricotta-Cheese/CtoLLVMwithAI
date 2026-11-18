_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2097152u) == 0u)) {
        acc = (acc ^ (x << 19u));
        acc = (acc ^ (y << 6u));
    } else {
        acc = (acc ^ (y << 5u));
        acc = (acc ^ ((31u - (acc ^ 1211767380u)) >> 3u));
    }
    acc = (acc ^ (y - acc));
    return acc;
}
