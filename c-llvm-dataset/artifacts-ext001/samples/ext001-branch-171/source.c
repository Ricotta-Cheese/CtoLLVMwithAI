_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (acc ^ y));
    } else {
        acc = (acc ^ (x + acc));
    }
    acc = (acc ^ ((y | x) << 3u));
    return acc;
}
